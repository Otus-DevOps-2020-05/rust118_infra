resource "yandex_lb_target_group" "my-app-group" {
  name      = "my-app-group"
  region_id = var.region

  target {
    subnet_id = var.subnetwork_id
    address = yandex_compute_instance.my-app[0].network_interface.0.ip_address
  }
  target {
    subnet_id = var.subnetwork_id
    address = yandex_compute_instance.my-app[1].network_interface.0.ip_address
  }
}

resource "yandex_lb_network_load_balancer" "my-app-lb" {
  name = "my-app-lb"

  attached_target_group {
    target_group_id = yandex_lb_target_group.my-app-group.id

    healthcheck {
      name = "http"
      http_options {
        port = 9292
        path = "/"
      }
    }
  }

  listener {
    name = "my-listener"
    port = 9292
    external_address_spec {
      ip_version = "ipv4"
    }
  }
}
