output "KEY_NAME"{
    value = aws_key_pair.ilearning-wordpress.key_name
}

output "KEY_ID"{
    value = aws_key_pair.ilearning-wordpress.key_pair_id
}

output "key_pair_region" {
 value = "us-east-2"
}