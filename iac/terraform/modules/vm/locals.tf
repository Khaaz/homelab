locals {
  raw_nics    = tolist(try(var.vm_cfg.nics, []))
  nameservers = tolist(try(var.vm_cfg.config.dns_servers, ["1.1.1.1", "8.8.8.8"]))

  # We only want to use cloud-init network file on complex setup (trunks). We can keep it simple otherwise
  use_ci_network_file = anytrue([
    for n in local.raw_nics : length(coalesce(n.trunks, [])) > 0
  ])

  # Generate stable locally-administered MACs
  # (based on vm_name + NIC index; prefix 02:69:… keeps "locally administered" bit set)
  mac_addresses = [
    for idx in range(length(local.raw_nics)) :
    lower(join(":", [
      "02", "69",
      substr(md5("${var.vm_name}-${idx}"), 0, 2),
      substr(md5("${var.vm_name}-${idx}"), 2, 2),
      substr(md5("${var.vm_name}-${idx}"), 4, 2),
      substr(md5("${var.vm_name}-${idx}"), 6, 2),
    ]))
  ]

  # Enriched NICs with index, interface name, mac, and normalized fields
  enriched_nics = [
    for index, nic in local.raw_nics : {
      index     = index
      interface = "eth${index}"                         # deterministic guest name
      mac       = local.mac_addresses[index]            # forced mac address
      bridge    = nic.bridge
      ipv4      = try(nic.ipv4, null)
      gateway   = try(nic.gateway, null)
      vlan_id   = try(nic.vlan, null)
      trunks    = [for t in coalesce(nic.trunks, []) : t.id] # VLAN IDs
      trunk_cfg = {                                     # id -> ipv4 (for convenience)
        for t in coalesce(nic.trunks, []) : 
          t.id => {
            ipv4    = t.ipv4
            gateway = t.gateway
          }
      }
    }
  ]

  # nics: one entry per physical NIC (access or trunk)
  nics = [
    for nic in local.enriched_nics : {
      interface = nic.interface         # base device name, e.g., eth0
      mac       = nic.mac               # forced mac address
      bridge    = nic.bridge
      # enforce config when trunked
      ipv4      = length(nic.trunks) > 0 ? null : nic.ipv4    # optional: null when trunked (IPs defined on VLANs)
      gateway   = length(nic.trunks) > 0 ? null : nic.gateway # optiona: null when trunked
      vlan_id   = length(nic.trunks) > 0 ? null : nic.vlan_id # optional: for vlan tagging
      trunks    = length(nic.trunks) > 0 ? nic.trunks : null  # optional: trunks
    }
  ]

  # vlans: one entry per VLAN subinterface (only for trunked NICs)
  vlans = flatten([
    for n in local.enriched_nics : [
      for trunk_id in n.trunks : {
        id        = trunk_id
        interface = n.interface                   # base device name, e.g., eth0
        ipv4      = n.trunk_cfg[trunk_id].ipv4    # IP on that VLAN
        gateway   = n.trunk_cfg[trunk_id].gateway # IP on that VLAN
      }
    ]
  ])
}
