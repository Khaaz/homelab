variable "proxmox_api_url" {
	type    = string
	default = env("PROXMOX_API_URL")
}

variable "proxmox_api_token_id" {
	type    = string
	default = env("PROXMOX_API_TOKEN_ID")
}

variable "proxmox_api_token_secret" {
	type      = string
	sensitive = true
	default   = env("PROXMOX_API_TOKEN_SECRET")
}

variable "proxmox_node" {
	type    = string
	default = env("PROXMOX_NODE")
}

# Setup machine IP (to fetch answer and root.pub)
variable "control_node_ip" {
	type    = string
	default = env("CONTROL_NODE_IP")
}

# Customise root password
variable "root_password" {
	type      = string
	sensitive = true
	default   = env("SSH_ROOT_PASSWORD")
}
