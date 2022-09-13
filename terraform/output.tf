output "yandex_zone" {
  value       = yandex_compute_instance.node01.zone
}

output "yandex_ip_private" {
  value       = yandex_compute_instance.node01.network_interface.0.ip_address
}

output "yandex_vpc_subnet" {
  value       = resource.yandex_vpc_subnet.subnet.id
}
