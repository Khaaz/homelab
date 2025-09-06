provider "proxmox" {
  endpoint  = var.proxmox_api_url
  api_token = var.proxmox_terraform_api_token
  insecure  = true

  ssh {
    username    = "automation"
    private_key = file(
      var.dev_mode ? 
        "${local.root_path}/config/ssh/proxmox/automation_key.dev" :
        "${local.root_path}/config/ssh/proxmox/automation_key"
    )
  }
}
