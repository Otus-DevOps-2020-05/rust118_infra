output "external_ip_address_my-app0" {
  value = yandex_compute_instance.my-app[0].network_interface.0.nat_ip_address
}

output "external_ip_address_my-app1" {
  value = yandex_compute_instance.my-app[1].network_interface.0.nat_ip_address
}

output "external_ip_address_my-lb1" {
  value = yandex_lb_network_load_balancer.my-app-lb.listener.*.external_address_spec.0.address
}
