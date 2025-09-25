terraform {
  # https://github.com/bpg/terraform-provider-proxmox
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.83.0"
    }
    toml = {
      source  = "Tobotimus/toml"
      version = "~> 0.3"
    }
    random = { 
      source = "hashicorp/random" 
      version = ">= 3.7.2"
    }
  }
}
