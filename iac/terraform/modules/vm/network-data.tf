resource "proxmox_virtual_environment_file" "networkdata" {
  count = local.use_ci_network_file ? 1 : 0
  
  content_type = "snippets"
  datastore_id = var.proxmox_datastore_id
  node_name    = var.proxmox_node

  source_raw {
    file_name = "${var.vm_name}-networkdata.yml"
    data = templatefile("${path.root}/cloud-init/network-data.tpl.yml", {
      nics  = local.nics
      vlans = local.vlans
      dns   = var.vm_cfg.dns_servers
    })
  }
}
