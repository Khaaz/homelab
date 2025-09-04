source "proxmox-iso" "alpine" {

  # Proxmox
  proxmox_url              = var.proxmox_api_url
  username                 = var.proxmox_api_token_id
  token                    = var.proxmox_api_token_secret
  insecure_skip_tls_verify = true

  # Template
  node                 = var.proxmox_node
  vm_id                = var.proxmox_vm_template_id
  vm_name              = var.proxmox_vm_template_name
  template_description = "Alpine virt with Cloud-Init + Docker"

  qemu_agent  = true
  disable_kvm = true # Disable only for VM

  cloud_init              = true # Let terraform provide it later on
  cloud_init_storage_pool = "local"
  cloud_init_disk_type    = "ide"

  # SSH
  communicator         = "ssh"
  ssh_username         = "root"
  ssh_private_key_file = "${path.root}/keys/root_key" # or id_rsa that matches root.pub
  ssh_timeout          = "30m"
  ssh_pty              = true

  # VM specs
  cores   = "1"
  sockets = "1"
  memory  = "1024"
  disks {
    type         = "scsi"
    format       = "raw"
    storage_pool = "local"
    disk_size    = "5G"
  }

  # bios specification settings
  os      = "l26"
  machine = "q35"  # use q35 over pc (more modern)
  bios    = "ovmf" #use omvf over seabios (more modern)
  efi_config {
    efi_storage_pool = "local"
    efi_type         = "4m"
  }

  # scsi controller
  scsi_controller = "virtio-scsi-pci"

  # video
  vga {
    type = "virtio"
  }

  # network
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
    "/root-key"     = file("${path.root}/keys/root_key.pub")
  }

  # Boot
  boot      = "order=scsi0;ide2;net0"
  boot_wait = "10s"
  boot_iso {
    type     = "ide"
    iso_file = "local:iso/alpine-virt-3.22.1-x86_64.iso"
    unmount  = true
    # iso_url = "https://dl-cdn.alpinelinux.org/alpine/v3.22/releases/x86_64/alpine-virt-3.22.1-x86_64.iso"
    # iso_checksum = "sha256:42918974513750a6923393f3074c3bb226badfce4a0d0f35f90377fd789fda1f"
    # iso_storage_pool= "local"
  }

  # Conditional boot commands depending on method
  # 1) login as root
  # 2) bring up net via DHCP
  # 3) fetch answers
  # 4) run setup-alpine (Packer types your ssh_password twice)
  # 5) reboot
  boot_command = [
    "<enter><wait60>", # boot default menu entry
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
