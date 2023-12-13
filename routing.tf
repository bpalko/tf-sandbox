resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "main-gw"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "main-rt"
  }
}

resource "aws_eip" "elastic_ip" {
  domain = "vpc"
  network_interface = aws_network_interface.webserver_nic.id
  associate_with_private_ip = "10.0.1.50"

  depends_on = [ aws_internet_gateway.gw ]
}