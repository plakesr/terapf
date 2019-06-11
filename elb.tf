# Create a new load balancer
resource "aws_elb" "myelb" {
  name               = "my-terraform-elb"
  availability_zones = ["${var.az}"]
  subnets =  ["${aws_subnet.public.*.id}"]
  security_groups = ["${aws_security_group.webserver.id}"]


  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }


  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/index.html"
    interval            = 30
  }

  instances                   = ["${aws_instance.webservers.*.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 100
  connection_draining         = true
  connection_draining_timeout = 100

  tags = {
    Name = "my-terraform-elb"
  }
}

output "elb-dns" {
  value = "${aws_elb.myelb.dns_name}"
}
