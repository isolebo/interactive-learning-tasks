locals{
  common_tags = {
    Name = "Hello World"
    Env = "Dev"
    Team = "DevOps"
  }
}


resource "aws_key_pair" "class" {
  key_name   = "class-key"
  public_key = file("~/.ssh/id_rsa.pub")
  tags = local.common_tags
}

resource "aws_ebs_volume" "example" {
  availability_zone = "us-east-1a"
  size              = 100
  tags = local.common_tags

}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.example.id
  instance_id = aws_instance.web.id

  
}


resource "aws_instance" "web" {

  ami  = "ami-ae6272b8"
  instance_type = "t2.micro"
  key_name = aws_key_pair.class.key_name 
  availability_zone = "us-east-1a"
  user_data = file("userdata.sh")
}

