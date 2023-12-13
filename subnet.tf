resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "main-sub"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.rt.id
}