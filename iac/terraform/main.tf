# Result is an object like { reverse-proxy = { enabled = true }, ... }
locals {
  toml_root = provider::toml::decode(file("${local.root_path}/config/global-config.toml"))

  enabled_vm_names = [
    for name, tbl in local.toml_root :
    name if try(tbl.enabled, false)
  ]
}

# ----- Discover per-VM YAML configs in ../../apps/<name>/src/config/proxmox-terraform.yml
locals {
  vm_config_files = fileset(local.root_path, "apps/*/src/config/proxmox-terraform.yml")

  # All VM configs keyed by folder name
  vms_all = {
    for f in local.vm_config_files :
    trimsuffix(trimprefix(f, "apps/"), "/src/config/proxmox-terraform.yml")
    => yamldecode(file("${local.root_path}/${f}"))
  }

  # Keep only those enabled by gloval-config.toml
  vms = {
    for name, cfg in local.vms_all :
    name => cfg if contains(local.enabled_vm_names, name)
  }
}

module "vm" {
  source   = "./modules/vm"
  for_each = local.vms

  vm_name = each.key
  vm_cfg  = each.value

  proxmox_node           = var.proxmox_node
  proxmox_vm_template_id = var.proxmox_vm_template_id
  proxmox_datastore_id   = var.proxmox_datastore_id

  # Pass the actual key *contents* into the module (simplest & portable).
  # If you truly use per-VM keys in config/ssh/<vm>/*, this matches your earlier "reverse-proxy" example:
  admin_pubkey   = trimspace(file("${local.root_path}/config/ssh/${each.key}/admin_key.pub"))
  ansible_pubkey = trimspace(file("${local.root_path}/config/ssh/${each.key}/ansible_key.pub"))
}
