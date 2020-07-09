output "network_id" {
  value = yandex_vpc_network.app-network.id
}

output "zone_id" {
  value = yandex_vpc_subnet.app-subnet.zone
}