provider "yandex" {
  service_account_key_file = var.svc_acct_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

module "app" {
  source           = "../modules/app"
  subnet_id        = var.subnet_id
  is_preemptible   = true
  env_name         = "stage"
  db_addr          = module.db.internal_ip_address_db
  do_provisioning  = false
}

module "db" {
  source           = "../modules/db"
  subnet_id        = var.subnet_id
  is_preemptible   = true
  env_name         = "stage"
}
