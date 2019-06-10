#VPC for application
resource "aws_vpc" "myvpc" {
  cidr_block = "${var.vpc_cidr}"

  tags = {
    Name = "MyVPC"
  }
}
#IGW for VPC
resource "aws_internet_gateway" "myigw" {
  vpc_id = "${aws_vpc.myvpc.id}"
  tags = {
    Name = "main"
  }
}
#subnet creation
resource "aws_subnet" "public" {
  count      = "${length(var.subnets_cidr)}"
  vpc_id     = "${aws_vpc.myvpc.id}"
  availability_zone = "${element(var.az, count.index)}"
  cidr_block = "${element(var.subnets_cidr, count.index)}"
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet-${count.index + 1}"
  }
}

#R_Table
resource "aws_route_table" "pub_rt" {
  vpc_id = "${aws_vpc.myvpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.myigw.id}"
  }

  tags = {
    Name = "pub_rt"
  }
}

#RT association with public subnet

resource "aws_route_table_association" "pub_attach" {
  count          = "${length(var.subnets_cidr)}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.pub_rt.id}"
}
