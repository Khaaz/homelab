# Result is an object like { reverse-proxy = { enabled = true }, ... }
locals {
  toml_root = provider::toml::decode(file("${local.root_path}/config/global-config.toml"))

  config_enabled_vm_names = [
    for name, tbl in local.toml_root :
    name if try(tbl.enabled, false)
  ]
}

# ----- Discover per-VM YAML configs in ../../apps/<name>/infra/proxmox.yml
locals {
  all_vms_infra_file = fileset(local.root_path, "apps/*/infra/proxmox.yml")

  # All VM configs keyed by folder name
  all_vms_to_infra_config = {
    for f in local.all_vms_infra_file :
    trimsuffix(trimprefix(f, "apps/"), "/infra/proxmox.yml") => yamldecode(file("${local.root_path}/${f}"))
  }

  # Keep only those enabled by global-config.toml
  enabled_vms_to_infra_config = {
    for name, cfg in local.all_vms_to_infra_config :
    name => cfg if contains(local.config_enabled_vm_names, name)
  }

  ordered_enabled_vms = sort(keys(local.enabled_vms_to_infra_config))

  # Map each VM name -> deterministic VMID
  vms_to_vmid = {
    for name in local.ordered_enabled_vms :
    name => 100 + index(local.ordered_enabled_vms, name)
  }
}

locals {
  # Group VMs by order_tier
  vms_by_tier = {
    for tier in distinct([for cfg in local.enabled_vms_to_infra_config : cfg.order_tier]) :
    tier => {
      for name, cfg in local.enabled_vms_to_infra_config :
      name => cfg if cfg.order_tier == tier
    }
  }
}

module "vm_tier0" {
  source   = "./modules/vm-tier"
  
  tier_vms    = local.vms_by_tier[0]
  vms_to_vmid = local.vms_to_vmid
  
  ## proxmox conf
  proxmox_node                    = var.proxmox_node
  proxmox_vm_template_virt_id     = var.proxmox_vm_template_virt_id
  proxmox_vm_template_standard_id = var.proxmox_vm_template_standard_id
  proxmox_datastore_id            = var.proxmox_datastore_id
}

module "vm_tier1" {
  source   = "./modules/vm-tier"
  
  tier_vms    = local.vms_by_tier[1]
  vms_to_vmid = local.vms_to_vmid

  ## proxmox conf
  proxmox_node                    = var.proxmox_node
  proxmox_vm_template_virt_id     = var.proxmox_vm_template_virt_id
  proxmox_vm_template_standard_id = var.proxmox_vm_template_standard_id
  proxmox_datastore_id            = var.proxmox_datastore_id
  
  depends_on = [ module.vm_tier0 ]
}

module "vm_tier2" {
  source   = "./modules/vm-tier"
  
  tier_vms    = local.vms_by_tier[2]
  vms_to_vmid = local.vms_to_vmid
  
  ## proxmox conf
  proxmox_node                    = var.proxmox_node
  proxmox_vm_template_virt_id     = var.proxmox_vm_template_virt_id
  proxmox_vm_template_standard_id = var.proxmox_vm_template_standard_id
  proxmox_datastore_id            = var.proxmox_datastore_id
  
  depends_on = [ module.vm_tier1 ]
}

module "vm_tier3" {
  source   = "./modules/vm-tier"
  
  tier_vms    = local.vms_by_tier[3]
  vms_to_vmid = local.vms_to_vmid
  
  ## proxmox conf
  proxmox_node                    = var.proxmox_node
  proxmox_vm_template_virt_id     = var.proxmox_vm_template_virt_id
  proxmox_vm_template_standard_id = var.proxmox_vm_template_standard_id
  proxmox_datastore_id            = var.proxmox_datastore_id
  
  depends_on = [ module.vm_tier2 ]
}
