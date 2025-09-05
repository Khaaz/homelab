provider "proxmox" {
  endpoint  = var.proxmox_api_url
  api_token = var.proxmox_api_token
  insecure  = true

  ssh {
    username    = "automation"
    private_key = file("${local.root_path}/config/ssh/proxmox/automation_key.dev") #TODO
  }
}
