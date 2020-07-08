provider "yandex" {
  service_account_key_file = var.svc_acct_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

module "app" {
  source           = "../modules/app"
  username         = var.username
  private_key_path = var.private_key_path
  public_key_path  = var.public_key_path
  disk_image       = var.app_disk_image
  subnet_id        = var.subnet_id
  db_addr          = module.db.internal_ip_address_db
  do_provisioning  = true
}

module "db" {
  source           = "../modules/db"
  private_key_path = var.private_key_path
  public_key_path  = var.public_key_path
  disk_image       = var.db_disk_image
  subnet_id        = var.subnet_id
}
