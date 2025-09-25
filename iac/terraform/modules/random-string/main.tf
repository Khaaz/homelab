resource "random_password" "this" {
  length           = var.length
  special          = true
  min_upper        = 1
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  override_special = var.override_special
}
