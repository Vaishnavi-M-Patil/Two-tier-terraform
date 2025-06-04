output "vpc_id" {
    value = aws_vpc.vpc.id 
}

output "pub_subnet_1_id" {
    value = aws_subnet.pub_subnet_1.id
}

output "pub_subnet_2_id" {
    value = aws_subnet.pub_subnet_2.id
}

output "pvt_subnet_1_id" {
    value = aws_subnet.pvt_subnet_1.id
}

output "pvt_subnet_2_id" {
    value = aws_subnet.pvt_subnet_2.id
}