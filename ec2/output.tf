
output "PUBLIC_IP"{

    value = aws_instance.web.public_ip
}

output "INSTANCE_ID"{

    value = aws_instance.web.id
}



output "AVAILABILITY_ZONE"{

    value = aws_instance.web.availability_zone
}


output "aws_instance_region" {
  value = "us-east-1"
}