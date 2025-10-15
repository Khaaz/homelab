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
        ] : [],
        try(var.vm_cfg.nas, null) != null ? [
          "nfs-utils",
          "nfs-utils-openrc"
        ] : []
      )
      write_files = concat(
        var.nft_rules_config != null ? [{
          path        = "/etc/nftables.d/firewall.nft"
          permissions = "0644"
          encoding    = "b64"
          content     = base64encode(var.nft_rules_config)
        }] : [],
        length(coalesce(var.vm_cfg.config.routes, [])) > 0 ? [{
          path        = "/etc/local.d/routes.start"
          permissions = "0755"
          encoding    = "b64"
          content     = base64encode(join("\n", concat(
            ["#!/bin/sh", "set -eu"],
            [for route in coalesce(var.vm_cfg.config.routes, []) : "ip route replace ${route.network} via ${route.via}"],
            [""]
          )))
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
        # Persist custom routes via OpenRC local.d
        length(coalesce(var.vm_cfg.config.routes, [])) > 0 ? [
          "[ /etc/local.d/routes.start ]",
          "[ rc-update, add, local, default ]"
        ] : [],
        try(var.vm_cfg.nas, null) != null ? [
          # Enable NFS client services
          "[ rc-update, add, nfsmount, boot ]",
          # Create NFS mount point
          "[ mkdir, -p, ${var.vm_cfg.nas.mount_path} ]",
          # Add NFSv4 mount to fstab (path should be relative to NFSv4 root)
          "echo \"${var.vm_cfg.nas.ip}:${var.vm_cfg.nas.nfs_export} ${var.vm_cfg.nas.mount_path} nfs4 _netdev,vers=4.2 0 0\" >> /etc/fstab",
          # Mount the NFS share
          "[ mount, -a ]"
        ] : [],
        var.init_script != null ? [
          "[ /root/init_script.sh ]",
          "[ rm, /root/init_script.sh ]"
        ] : []
      )
    })
  }
}
