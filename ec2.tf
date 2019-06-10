resource "aws_instance" "webservers" {
  count = "${length(var.subnets_cidr)}"
  ami = "${var.web_ami}"
  instance_type = "${var.ins_type}"
  security_groups = ["${aws_security_group.webserver.id}"]
  subnet_id = "${element(aws_subnet.public.*.id,count.index)}"
  user_data     = "${file("apache.sh")}"

}
