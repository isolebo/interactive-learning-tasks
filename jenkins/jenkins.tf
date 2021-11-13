
resource "aws_key_pair" "class" {
  key_name   = "class_key"
  public_key = file("~/.ssh/id_rsa.pub")
}


resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  availability_zone      = data.aws_availability_zones.all.names[0]
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  key_name               = aws_key_pair.class.key_name

}


resource "null_resource" "commands" {
  depends_on = [aws_instance.web]
  triggers = {
    always_run = timestamp()
  }


  provisioner "remote-exec" {
    connection {
      host        = aws_instance.web.public_ip
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
    }

    inline = [
      
      " sudo echo deb http://repo.r1soft.com/apt stable main >>/etc/apt/sources.list",
      " wget http://repo.r1soft.com/r1soft.asc  " ,
      " apt-key add r1soft.asc  "  ,
      " sudo    apt-get update -y  ",
      " sudo   apt-get install serverbackup-enterprise -y",
      " serverbackup-setup --http-port 80 --https-port 443 ",
      "  serverbackup-setup --user admin --pass r1soft "

    ]
  }
}