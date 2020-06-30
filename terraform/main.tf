provider "yandex" {
  service_account_key_file = var.svc_acct_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
}

resource "yandex_compute_instance" "my-app" {

  name = "reddit-app${count.index}"
  zone = var.zone
  count = var.instances

  connection {
    type        = "ssh"
    host        = self.network_interface.0.nat_ip_address
    user        = "ubuntu"
    agent       = false
    private_key = file("~/.ssh/yc")
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }

  resources {
    core_fraction = 5
    cores         = 1
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }

  network_interface {
    subnet_id = "e9b4dgtdmm1crembp9at"
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
}
