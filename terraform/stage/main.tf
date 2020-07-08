provider "yandex" {
  service_account_key_file = var.svc_acct_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

resource "yandex_vpc_network" "app-network" {
  name = "reddit-app-network"
}

resource "yandex_vpc_subnet" "app-subnet" {
  name           = "reddit-app-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.app-network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

module "app" {
  source           = "../modules/app"
  username         = var.username
  private_key_path = var.private_key_path
  public_key_path  = var.public_key_path
  disk_image       = var.app_disk_image
  subnet_id        = yandex_vpc_subnet.app-subnet.id
  do_provisioning  = true
  db_addr          = module.db.internal_ip_address_db
}

module "db" {
  source           = "../modules/db"
  private_key_path = var.private_key_path
  public_key_path  = var.public_key_path
  disk_image       = var.db_disk_image
  subnet_id        = yandex_vpc_subnet.app-subnet.id
}
