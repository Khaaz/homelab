terraform {
	# https://github.com/bpg/terraform-provider-proxmox
  	required_providers {
		proxmox = {
		source = "bpg/proxmox"
		version = "0.83.0"
		}
	}
}

provider "proxmox" {
	endpoint = var.proxmox_api_url
	api_token = var.proxmox_api_token
	insecure = true

	ssh {
		username = "ansible"
		private_key = file("../../config/ssh/proxmox/ansible_key.dev")
	}
}

# paths to your public keys (read on the Terraform machine)
locals {
  admin_pubkey   = trimspace(file("../../config/ssh/reverse-proxy/admin_key.pub"))
  ansible_pubkey = trimspace(file("../../config/ssh/reverse-proxy/ansible_key.pub"))
}

# --- cloud-init user-data snippet (users + hostname)
resource "proxmox_virtual_environment_file" "reverse_proxy_userdata" {
	content_type = "snippets"
	datastore_id = "local"
	node_name    = var.proxmox_node

	source_raw {
  file_name = "reverse-proxy-userdata.yaml"
  data = <<-CLOUD
  #cloud-config
  hostname: reverse-proxy
  manage_etc_hosts: true
  ssh_pwauth: false

  users:
    - name: admin
      groups: [wheel]
      sudo: ["ALL=(ALL) NOPASSWD:ALL"]
      shell: /bin/sh
      lock_passwd: true
      ssh_authorized_keys:
        - ${local.admin_pubkey}

    - name: ansible
      groups: [wheel]
      sudo: ["ALL=(ALL) NOPASSWD:ALL"]
      shell: /bin/sh
      lock_passwd: true
      ssh_authorized_keys:
        - ${local.ansible_pubkey}
  CLOUD
}
}

# --- reverse-proxy: NIC on vmbr1 and vmbr2
resource "proxmox_virtual_environment_vm" "reverse_proxy" {
	name      = "reverse-proxy"
	node_name = var.proxmox_node

	# Clone from existing template (by VMID)
	clone {
		node_name = var.proxmox_node
		vm_id     = var.proxmox_vm_template_id
	}

	agent {
		enabled = true
	}
	stop_on_destroy = true

	cpu { 
		cores = 2 
		# type = "x86-64-v2-AES"
	}
	memory { 
		dedicated = 2048
		# floating = 2048 # enable ballooning (same as dedicated) 
	}
	boot_order    = ["scsi0"]

	disk {
		interface    = "scsi0"
		iothread     = true
		datastore_id = "local"
		size         = 10
		discard      = "ignore"
	}

	# Ignore changes to the network
	## MAC address is generated on every apply, causing
	## TF to think this needs to be rebuilt on every apply
	lifecycle {
		ignore_changes = [
			network_device,
		]
	}

	# matches template setup
	bios = "ovmf"
	machine = "q35"
	operating_system {
		type = "l26"   # Linux 2.6+ (covers modern Linux)
	}
	# scsi_hardware = "virtio-scsi-pci"
	scsi_hardware = "virtio-scsi-single"

	efi_disk {
		datastore_id = "local"
		type = "4m"
	}

	# NICs (order matters for ip_config below)
	network_device {
		bridge = "vmbr1" # 10.10.1.0/24
		model  = "virtio"
	}
	network_device {
		bridge = "vmbr2" # 10.10.2.0/24
		model  = "virtio"
	}

	# Cloud-Init
	initialization {
		datastore_id = "local"
		interface    = "ide1"

		# DNS servers (replaces 'nameserver')
		dns {
			servers = ["1.1.1.1", "8.8.8.8"]
		}

		# One ip_config block per NIC, in the same order as network_device
		ip_config {
			ipv4 {
				address = "10.10.1.2/24"
				gateway = "10.10.1.1"
			}
		}
		ip_config {
			ipv4 {
				address = "10.10.2.2/24"
			}
		}

		user_data_file_id = proxmox_virtual_environment_file.reverse_proxy_userdata.id
	}
}

# # --- media-management: vmbr1, static 10.10.1.10
# resource "proxmox_virtual_environment_vm" "media_management" {
#   name      = "media-management"
#   node_name = var.proxmox_node

#   clone {
#     node_name = var.proxmox_node
#     vm_id     = var.proxmox_vm_template_id
#   }

#   agent { enabled = true }

#   cpu { cores = 2 }
#   memory { 
	# 	dedicated = 2048
	# 	floating = 2048 # enable ballooning (same as dedicated) 
 	# }

#   network_device {
#     bridge = "vmbr1"
#     model  = "virtio"
#   }

#   initialization {
# 	datastore_id = "local"

#     dns { servers = ["1.1.1.1", "8.8.8.8"] }

#     user_account {
#       username = "admin"
#       # keys     = [var.ssh_pubkey]
#     }

#     ip_config {
#       ipv4 {
#         address = "10.10.1.10/24"
#         gateway = "10.10.1.1"
#       }
#     }
#   }
# }

# # --- media-server: vmbr2, static 10.10.2.10
# resource "proxmox_virtual_environment_vm" "media_server" {
#   name      = "media-server"
#   node_name = var.proxmox_node

#   clone {
#     node_name = var.proxmox_node
#     vm_id     = var.proxmox_vm_template_id
#   }

#   agent { enabled = true }

#   cpu { cores = 2 }
#   memory { 
# 	dedicated = 2048
# 	floating = 2048 # enable ballooning (same as dedicated) 
#   }

#   network_device {
#     bridge = "vmbr2"
#     model  = "virtio"
#   }

#   initialization {
# 	datastore_id = "local"

#     dns { servers = ["1.1.1.1", "8.8.8.8"] }

#     user_account {
#       username = "admin"
#       # keys     = [var.ssh_pubkey]
#     }

#     ip_config {
#       ipv4 {
#         address = "10.10.2.10/24"
#         gateway = "10.10.2.1"
#       }
#     }
#   }
# }
