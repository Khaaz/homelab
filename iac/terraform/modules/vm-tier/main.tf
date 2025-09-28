module "vm_tier" {
  source   = "../vm"
  for_each = var.tier_vms
  
  vm_name = each.key
  vm_cfg  = each.value
  vm_id   = var.vms_to_vmid[each.key]

  ## proxmox conf
  proxmox_node           = var.proxmox_node
  proxmox_vm_template_id = var.proxmox_vm_template_id
  proxmox_datastore_id   = var.proxmox_datastore_id

  ## Cloud init
  # user-data
  admin_pubkey      = trimspace(file("${local.root_path}/config/ssh/${each.key}/admin_key.pub"))
  automation_pubkey = trimspace(file("${local.root_path}/config/ssh/${each.key}/automation_key.pub"))
  # vendor-data
  # nftable conf (/infra/nftable.conf)
  nft_rules_config  = fileexists("${local.root_path}/apps/${each.key}/infra/nftable.conf") ? file("${local.root_path}/apps/${each.key}/infra/nftable.conf") : null
  # additional init script (/infra/init.sh)
  init_script       = fileexists("${local.root_path}/apps/${each.key}/infra/init.sh") ? file("${local.root_path}/apps/${each.key}/infra/init.sh") : null
}
