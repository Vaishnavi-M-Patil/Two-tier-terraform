resource "aws_instance" "appln_server_1" {
    ami = var.ami_name
    instance_type = var.instance_type
    key_name = "two-tier-key"
    vpc_security_group_ids = [aws_security_group.appln_sg.id]
    subnet_id = var.pub_subnet_1_id

    user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install httpd -y
    systemctl start httpd
    systemctl enable httpd
    echo "<h1> This is $(hostname) </h1>" > /var/www/html/index.html
    EOF

    tags = {
      project = "two-tier-project"
    }
}

resource "aws_instance" "appln_server_2" {
    ami = var.ami_name
    instance_type = var.instance_type
    key_name = "two-tier-key"
    vpc_security_group_ids = [aws_security_group.appln_sg.id]
    subnet_id = var.pub_subnet_2_id

    user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install httpd -y 
    systemctl start httpd
    systemctl enable httpd
    echo "<h1> This is $(hostname) </h1>" > /var/www/html/index.html
    EOF

    tags = {
      project = "two-tier-project"
    }
}

#create application laod balancer
resource "aws_lb" "appln_load_balancer" {
  name               = "appln-load-balancer"
  internal = false                                             # Makes it internet-facing.
  load_balancer_type = "application"                           # load balancer type
  security_groups    = [ aws_security_group.appln_sg.id ]
  subnets            = [ var.pub_subnet_1_id , var.pub_subnet_2_id ]

  tags = {
    project = "two-tier-project"
  }
}

resource "aws_lb_target_group" "appln_load_balancer_tg" {
  name     = "appln-load-balacer-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

# Create Load Balancer listener
resource "aws_lb_listener" "two-tier-lb-listner" {
  load_balancer_arn = aws_lb.appln_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.appln_load_balancer_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "two-tier-tg-attch-1" {
  target_group_arn = aws_lb_target_group.appln_load_balancer_tg.arn
  target_id        = aws_instance.appln_server_1.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "two-tier-tg-attch-2" {
  target_group_arn = aws_lb_target_group.appln_load_balancer_tg.arn
  target_id        = aws_instance.appln_server_2.id
  port             = 80
}

resource "aws_eip" "appln_server_1_eip" {
  instance = aws_instance.appln_server_1.id
}

resource "aws_eip" "appln_server_2_eip" {
  instance = aws_instance.appln_server_2.id
}

resource "aws_security_group" "appln_sg" {
    name ="appln_sg"
    vpc_id = var.vpc_id

    ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    project = "security group for application"
  }

}
