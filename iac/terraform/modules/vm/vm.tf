resource "proxmox_virtual_environment_vm" "vm" {
  name      = var.vm_name
  node_name = var.proxmox_node
  vm_id     = var.vm_id

  # Clone from template VM ID
  clone {
    node_name = var.proxmox_node
    vm_id     = var.proxmox_vm_template_id
  }

  agent {
    enabled = true
  }
  stop_on_destroy = true
  startup {
    order      = "${var.vm_cfg.order}"
    up_delay   = "60"
    down_delay = "60"
  }

  cpu {
    cores = try(var.vm_cfg.cores, 1)
    type  = "x86-64-v2-AES"
  }
  memory {
    dedicated = try(var.vm_cfg.ram_size, 2048)
    floating  = try(var.vm_cfg.ram_size, 2048) # enable ballooning (if floating = dedicated) 
  }

  boot_order = ["scsi0"]

  disk {
    interface    = "scsi0"
    iothread     = true
    datastore_id = var.proxmox_datastore_id
    size         = try(var.vm_cfg.disk_size, 10)
    discard      = "ignore"
  }

  # Ignore changes to the network
	# MAC address is generated on every apply, causing Terraform to think this needs to be rebuilt on every apply
  lifecycle { 
    ignore_changes = [network_device] 
  }

  # Modern Linux template defaults - matches packer template
  bios    = "ovmf"
  machine = "q35"
  operating_system {
    type = "l26" # Linux 2.6+ (covers modern Linux) 
  }
  scsi_hardware = "virtio-scsi-single"
  # scsi_hardware = "virtio-scsi-pci"

  efi_disk {
    datastore_id = var.proxmox_datastore_id
    type         = "4m"
  }

  # NICs: dynamic number & order from config.yaml
  dynamic "network_device" {
    for_each = tolist(try(local.nics, []))
    content {
      bridge        = network_device.value.bridge
      model         = "virtio"
      mac_address = network_device.value.mac

      # Conditionally add VLAN tag if present
      vlan_id = try(network_device.value.vlan_id, null)
      # Conditionnaly add trunks if present
      # If any network device as trunks enabled, we will use network file instead of ip_config
      trunks  = (length(coalesce(network_device.value.trunks, [])) > 0 
        ? join(";", [for v in network_device.value.trunks : tostring(v)])
        : null
      )
    }
  }

  # Cloud-Init
  initialization {
    datastore_id = var.proxmox_datastore_id
    interface    = "ide2"

    dns {
      servers = try(var.vm_cfg.dns_servers, ["1.1.1.1", "8.8.8.8"])
    }

    # One ip_config per NIC, same order
    # Use network file if one NIC use trunk
    dynamic "ip_config" {
      for_each = local.use_ci_network_file ? [] : [for n in local.nics : n if n.ipv4 != null]
      content {
        ipv4 {
          address = ip_config.value.ipv4
          gateway = try(ip_config.value.gateway, null)
        }
      }
    }

    user_data_file_id    = proxmox_virtual_environment_file.userdata.id
    network_data_file_id = try(proxmox_virtual_environment_file.networkdata[0].id, null)
    vendor_data_file_id  = try(proxmox_virtual_environment_file.vendordata[0].id, null)
  }
}
