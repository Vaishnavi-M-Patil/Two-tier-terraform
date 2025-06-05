output "appln_load_balancer_dns_name" {
    value       = module.application.lb_dns
}

output "Public_IP_of_webserver_1" {
    value       = module.application.public_ip_of_webserver_1
}

output "Public_IP_of_webserver_2" {
    value       = module.application.public_ip_of_webserver_2
}