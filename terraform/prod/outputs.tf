output "external_ip_address_my-app" {
  value = module.app.external_ip_address_app
}

output "external_ip_address_my-db" {
  value = module.db.external_ip_address_db
}

output "internal_ip_address_my-db" {
  value = module.db.internal_ip_address_db
}
