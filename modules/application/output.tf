output "appln_server_1_id" {
    value = aws_instance.appln_server_1.id
}

output "appln_server_2_id" {
    value = aws_instance.appln_server_2.id
}

output "lb_dns" {
    value = aws_lb.appln_load_balancer.dns_name
}