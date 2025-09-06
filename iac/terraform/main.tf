# Result is an object like { reverse-proxy = { enabled = true }, ... }
locals {
  toml_root = provider::toml::decode(file("${local.root_path}/config/global-config.toml"))

  config_enabled_vm_names = [
    for name, tbl in local.toml_root :
    name if try(tbl.enabled, false)
  ]
}

# ----- Discover per-VM YAML configs in ../../apps/<name>/src/config/proxmox-terraform.yml
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

module "vm" {
  source   = "./modules/vm"
  for_each = local.enabled_vms_to_infra_config
  vm_name = each.key
  vm_cfg  = each.value
  vm_id   = local.vms_to_vmid[each.key]

  ## proxmox conf
  proxmox_node           = var.proxmox_node
  proxmox_vm_template_id = var.proxmox_vm_template_id
  proxmox_datastore_id   = var.proxmox_datastore_id

  ## Cloud init
  # user-data
  admin_pubkey      = trimspace(file("${local.root_path}/config/ssh/${each.key}/admin_key.pub"))
  automation_pubkey = trimspace(file("${local.root_path}/config/ssh/${each.key}/automation_key.pub"))
  # vendor-data
  nft_rules_config  = fileexists("${local.root_path}/apps/${each.key}/infra/nftable.conf") ? file("${local.root_path}/apps/${each.key}/infra/nftable.conf") : null
}
