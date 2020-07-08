resource "yandex_compute_instance" "app" {

  name = "reddit-app"

  labels = {
    tags = "reddit-app"
  }

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
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
    user        = "ubuntu"
    agent       = false
    private_key = file(var.private_key_path)
  }

  metadata = {
    ssh-keys = "var.username:${file(var.public_key_path)}"
  }

  provisioner "remote-exec" {
    inline = var.do_provisioning == false ? [] : [
      "sleep 30 && sudo apt-get install -y git",
      "git clone -b monolith https://github.com/express42/reddit.git /home/${var.username}/app",
      "cd /home/${var.username}/app && bundle install",
      "echo '[Unit]'                                      >> /tmp/puma.service",
      "echo 'Description=Puma HTTP Server'                >> /tmp/puma.service",
      "echo 'After=network.target'                        >> /tmp/puma.service",
      "echo '\n[Service]'                                 >> /tmp/puma.service",
      "echo 'Type=simple'                                 >> /tmp/puma.service",
      "echo 'User=${var.username}'                        >> /tmp/puma.service",
      "echo 'Group=${var.username}'                       >> /tmp/puma.service",
      "echo 'WorkingDirectory=/home/${var.username}/app'  >> /tmp/puma.service",
      "echo 'Environment=DATABASE_URL=${var.db_addr}'     >> /tmp/puma.service",
      "echo 'ExecStart=/usr/local/bin/puma'               >> /tmp/puma.service",
      "echo 'Restart=always'                              >> /tmp/puma.service",
      "echo '\n[Install]'                                 >> /tmp/puma.service",
      "echo 'WantedBy=multi-user.target'                  >> /tmp/puma.service",
      "sudo mv /tmp/puma.service /etc/systemd/system/",
      "sudo systemctl enable puma.service && sudo systemctl start puma.service"
    ]
  }
}
