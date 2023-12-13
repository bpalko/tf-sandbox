resource "aws_vpc" "test_vpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "main-vpc"
  }
}

resource "aws_network_interface" "webserver_nic" {
  subnet_id       = aws_subnet.subnet.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.test_sg.id]

}
