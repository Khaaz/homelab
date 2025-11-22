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
    order = var.vm_cfg.order_tier
    up_delay   = var.is_last_of_tier ? 30 : null
    down_delay = var.is_last_of_tier ? 30 : null
  }

  cpu {
    cores = try(var.vm_cfg.specs.cores, 1)
    type  = "x86-64-v2-AES"
  }
  memory {
    dedicated = try(var.vm_cfg.specs.ram_size, 2048)
    floating  = try(var.vm_cfg.specs.ram_size, 2048) # enable ballooning (if floating = dedicated) 
  }

  boot_order = ["scsi0"]

  disk {
    interface    = "scsi0"
    iothread     = true
    datastore_id = var.proxmox_datastore_id
    size         = try(var.vm_cfg.specs.disk_size, 10)
    discard      = "ignore"
  }

  # Additional disks (regular or passthrough)
  dynamic "disk" {
    for_each = try(var.vm_cfg.specs.additional_disks, [])
    iterator = additional_disk
    content {
      interface    = "scsi${additional_disk.key + 1}"  # scsi1, scsi2, etc.
      iothread     = true
      # Disk passthrough mode (when passthrough is set) (use mapping for non-root users):
      #   - datastore_id must be "" (empty string, not null)
      #   - file_format must be "raw"
      #   - path_in_datastore contains the host device path
      # Regular disk mode (when size is set):
      #   - datastore_id = actual datastore
      #   - size = disk size in GB
      datastore_id = try(additional_disk.value.passthrough, null) != null ? "" : var.proxmox_datastore_id
      size         = try(additional_disk.value.size, null)
      file_format  = try(additional_disk.value.passthrough, null) != null ? "raw" : null
      path_in_datastore = try(additional_disk.value.passthrough, null)
      discard      = "ignore"
    }
  }

  # PCI Device Passthrough (SATA controllers, GPUs, etc.)
  # Supports either direct PCI ID (requires root) or resource mapping (non-root)
  dynamic "hostpci" {
    for_each = try(var.vm_cfg.specs.pci_devices, [])
    iterator = pci
    content {
      device  = "hostpci${pci.key}"
      # Use mapping if provided (for non-root users), otherwise use direct PCI ID
      id      = try(pci.value.id, null)       # Direct PCI address: "0000:00:17.0" (requires root)
      mapping = try(pci.value.mapping, null)  # Resource mapping: "pci_igpu_mapping" (non-root)
      pcie    = true                          # Always enable PCIe for modern systems
      rombar  = true                          # Enable option ROM (required for most devices)
      xvga    = false                         # Not primary display
    }
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

  # NICs: dynamic number & order from proxmox.yml
  dynamic "network_device" {
    for_each = tolist(try(local.nics, []))
    content {
      bridge      = network_device.value.bridge
      model       = "virtio"
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
      servers = try(local.nameservers, ["1.1.1.1", "8.8.8.8"])
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
    vendor_data_file_id  = proxmox_virtual_environment_file.vendordata.id
  }
}
