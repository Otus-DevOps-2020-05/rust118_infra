resource "yandex_lb_target_group" "my-app-group" {
  name      = "my-app-group"
  region_id = var.region

  dynamic "target" {
    for_each = [
      for instances_list in yandex_compute_instance.my-app : {
        address = instances_list.network_interface.0.ip_address
        network = instances_list.network_interface.0.subnet_id
      }
    ]
    content {
      address   = target.value.address
      subnet_id = target.value.network
    }
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
