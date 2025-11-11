source "proxmox-iso" "template-alpine" {
  # Proxmox
  proxmox_url              = "${var.proxmox_api_url}/api2/json"
  username                 = var.proxmox_packer_token_id
  token                    = var.proxmox_packer_token_secret
  insecure_skip_tls_verify = true

  # Template
  node                 = var.proxmox_node
  vm_id                = var.proxmox_vm_template_id
  vm_name              = var.proxmox_vm_template_name
  template_description = "Alpine ${var.proxmox_vm_template_type} with Cloud-Init + Docker"

  qemu_agent  = true
  disable_kvm = false # Disable only for VM

  # Let terraform provide it later on
  cloud_init              = false 

  # SSH
  communicator         = "ssh"
  ssh_username         = "root"
  ssh_private_key_file = "${path.root}/../../config/ssh/vm/root_key"
  ssh_timeout          = "30m"
  ssh_pty              = true

  # VM specs
  cores   = "1"
  sockets = "1"
  memory  = "1024"
  disks {
    type         = "scsi"
    format       = "raw"
    storage_pool = var.proxmox_datastore_id
    disk_size    = "5G"
  }

  # Bios specification settings
  os      = "l26"
  machine = "q35"  # Use q35 over pc (more modern)
  bios    = "ovmf" # Use omvf over seabios (more modern)
  efi_config {
    efi_storage_pool = var.proxmox_datastore_id
    efi_type         = "4m"
  }

  # SCSI controller
  scsi_controller = "virtio-scsi-pci"

  # Video
  vga {
    type = "virtio"
  }

  # Network
  network_adapters {
    model  = "virtio"
    bridge = "vmbr0"
  }

  # HTTP server (for answer file)
  http_port_min = 8098
  http_port_max = 8098
  http_content = {
    "/answers"      = templatefile("${path.root}/config/answers.pkrtpl.hcl", { control_node_ip = "${var.control_node_ip}" })
    "/post-install" = file("${path.root}/config/post_install.sh")
    "/root-key"     = file("${path.root}/../../config/ssh/vm/root_key.pub")
  }

  # Boot
  boot      = "order=scsi0;ide2;net0"
  boot_wait = "10s"
  boot_iso {
    type     = "ide"
    iso_file = "local:iso/alpine-${var.proxmox_vm_template_type}-3.22.2-x86_64.iso"
    unmount  = true
  }

  # Conditional boot commands depending on method
  # 1) login as root
  # 2) bring up net via DHCP
  # 3) fetch answers
  # 4) run setup-alpine (Packer types your ssh_password twice)
  # 5) reboot
  boot_command = [
    "<enter><wait20>", # boot default menu entry
    "root<enter><wait>",
    # setup network
    "ifconfig eth0 up || ip link set eth0 up || ip link set ens18 up<enter><wait>",
    "udhcpc -i eth0 || udhcpc -i ens18<enter><wait5>",
    # DL answer file and setup alpine
    "wget -O /root/answers http://${var.control_node_ip}:{{ .HTTPPort }}/answers<enter><wait>",
    "USE_EFI=1 setup-alpine -f /root/answers<enter><wait10>",
    "${var.root_password}<enter><wait>",   # root password (prompt 1)
    "${var.root_password}<enter><wait30>", # root password (prompt 2)
    "<wait>y<enter><wait10>",              # accept disk overwrite warning
    # post install: QEMU guest aent + cloud init
    "wget -O /root/post_install.sh http://${var.control_node_ip}:{{ .HTTPPort }}/post-install<enter><wait>",
    "chmod +x /root/post_install.sh<enter><wait>",
    "/root/post_install.sh<enter><wait>",
    "reboot<enter>"
  ]
}
