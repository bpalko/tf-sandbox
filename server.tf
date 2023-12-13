resource "aws_instance" "web_server" {
  ami = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"

  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.webserver_nic.id
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install apache2 -y
              sudo systemctl start apache2
              sudo bash -c 'echo new webserver > /var/www/html/index.html'
              EOF
  tags = {
    Name = "web-server"
  }

}