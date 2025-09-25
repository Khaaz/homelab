resource "proxmox_virtual_environment_file" "vendordata" {
  content_type = "snippets"
  datastore_id = var.proxmox_datastore_id
  node_name    = var.proxmox_node

  source_raw {
    file_name = "${var.vm_name}-vendordata.yml"
    data = templatefile("${path.root}/cloud-init/vendor-data.tpl.yml", {
      packages = concat(
        var.vm_cfg.config.docker ? [
          "docker",
          "docker-cli-compose"
        ] : []
      )
      write_files = concat(
        var.nft_rules_config != null ? [{
          path        = "/etc/nftables.d/firewall.nft"
          permissions = "0644"
          encoding    = "b64"
          content     = base64encode(var.nft_rules_config)
        }] : [],
        var.init_script != null ? [{
          path        = "/root/init_script.sh"
          permissions = "0755"
          encoding    = "b64"
          content     = base64encode(var.init_script)
        }] : []
      )
      run_commands = concat(
        var.vm_cfg.config.router ? [
          "[ sysctl, -w, net.ipv4.ip_forward=1 ]",
          "echo \"net.ipv4.ip_forward=1\" >> /etc/sysctl.conf"
        ] : [],
        var.vm_cfg.config.docker ? [
          "[ rc-service, cgroups, start ]",
          "[ rc-update, add, docker, default ]",
          "[ rc-service, docker, start ]"
        ] : [],
        var.nft_rules_config != null ? [
          "[ rc-update, add, nftables, boot ]",
          "[ rc-service, nftables, start ]"
        ] : [],
        [for route in coalesce(var.vm_cfg.config.routes, []) : "[ ip, route, add, ${route.network}, via, ${route.via} ]"],
        var.init_script != null ? [
          "[ /root/init_script.sh ]",
          "[ rm, /root/init_script.sh ]"
        ] : []
      )
    })
  }
}
