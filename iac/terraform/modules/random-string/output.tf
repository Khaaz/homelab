output "value" {
  value     = random_password.this.result
  sensitive = true
}
