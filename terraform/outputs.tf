output "my-app_external_ip_addresses" {
  value = yandex_compute_instance.my-app[*].network_interface.0.nat_ip_address
}

output "my-lb_external_ip_address" {
  value = yandex_lb_network_load_balancer.my-app-lb.listener.*.external_address_spec.0.address
}
