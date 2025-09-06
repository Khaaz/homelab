resource "proxmox_virtual_environment_file" "userdata" {
  content_type = "snippets"
  datastore_id = var.proxmox_datastore_id
  node_name    = var.proxmox_node

  source_raw {
    file_name = "${var.vm_name}-userdata.yml"
    data = templatefile("${path.root}/cloud-init/user-data.tpl.yml", {
      admin_pubkey      = var.admin_pubkey
      automation_pubkey = var.automation_pubkey
      hostname          = var.vm_name
    })
  }
}
