resource "proxmox_virtual_environment_file" "vendordata" {
  count = var.nft_rules_config != null ? 1 : 0
  
  content_type = "snippets"
  datastore_id = var.proxmox_datastore_id
  node_name    = var.proxmox_node

  source_raw {
    file_name = "${var.vm_name}-vendordata.yml"
    data = templatefile("${path.root}/cloud-init/vendor-data.tpl.yml", {
      nft_rules_config_b64 = base64encode(var.nft_rules_config)
    })
  }
}
