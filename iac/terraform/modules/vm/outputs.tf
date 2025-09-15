output "nics" {
  description = "Computed NICs"
  value = local.nics
}

output "vlans" {
  description = "Computed VLAN subinterfaces"
  value = local.vlans
}

output "template" {
  description = "template"
  value = local.template
}
