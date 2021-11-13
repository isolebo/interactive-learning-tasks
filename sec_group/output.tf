

output "OWNERID"{
    value = aws_security_group.external_by_terraform.owner_id
}

output "ARN"{
    value = aws_security_group.external_by_terraform.arn
}

output "ID"{
    value = aws_security_group.external_by_terraform.id
}