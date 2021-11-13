
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
  ami                    = data.aws_ami.centos.id
  instance_type          = "t3.micro"
  availability_zone      = data.aws_availability_zones.all.names[0]
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  key_name               = aws_key_pair.class.key_name
}

resource "aws_instance" "web2" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  availability_zone      = data.aws_availability_zones.all.names[0]
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  key_name               = aws_key_pair.class.key_name
}


resource "null_resource" "commands" {
  depends_on = [aws_instance.web, aws_instance.web2]
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

      " sudo cd /tmp",
      " sudo wget https://assets.nagios.com/downloads/nagiosxi/xi-latest.tar.gz",
      "tar xzf xi-latest.tar.gz",
      "cd nagiosxi",
      "./fullinstal"

    ]
  }
}