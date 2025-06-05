output "appln_server_1_id" {
    value = aws_instance.appln_server_1.id
}

output "appln_server_2_id" {
    value = aws_instance.appln_server_2.id
}

output "lb_dns" {
    value = aws_lb.appln_load_balancer.dns_name
}

output "public_ip_of_webserver_1" {
    value = aws_instance.appln_server_1.public_ip
}

output "public_ip_of_webserver_2" {
    value = aws_instance.appln_server_2.public_ip
}