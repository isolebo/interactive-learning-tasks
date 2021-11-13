
output "ZONE_ID"{
    value = aws_route53_record.www.zone_id
}

output "NAME"{
    value = aws_route53_record.www.name
}

output "RECORDS"{
    value = aws_route53_record.www.records
}
