#VPC for application
resource "aws_vpc" "myvpc" {
  cidr_block       = "${var.vpc_cidr}"

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
  count = "${length(var.subnets_cidr)}"
  vpc_id     = "${aws_vpc.myvpc.id}"
  cidr_block  = "${element(var.subnets_cidr,count.index)}"

  tags = {
    Name = "Subnet-${count.index +1}"
  }
}
