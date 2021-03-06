resource "yandex_compute_instance" "db" {

  name = "reddit-db"

  labels = {
    tags = "db"
    env  = var.env_name
  }

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }

  scheduling_policy {
     preemptible = var.is_preemptible
  }

  boot_disk {
    initialize_params {
      image_id = var.disk_image
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  connection {
    type        = "ssh"
    host        = self.network_interface.0.nat_ip_address
    user        = var.username
    agent       = false
    private_key = file(var.private_key_path)
  }

  metadata = {
    ssh-keys = "var.username:${file(var.public_key_path)}"
  }
}
