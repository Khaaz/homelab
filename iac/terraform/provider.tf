provider "proxmox" {
  endpoint  = var.proxmox_api_url
  api_token = var.proxmox_api_token
  insecure  = true

  ssh {
    username    = "ansible"
    private_key = file("${local.root_path}/config/ssh/proxmox/ansible_key.dev")
  }
}
