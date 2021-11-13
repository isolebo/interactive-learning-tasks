resource "aws_route53_record" "www" {
  zone_id =  "Z04351853NLZ745NKF1C"
  name    = "wordpress.isolebo365.com"
  type    = "A"
  ttl     = "300"
  records  = [aws_instance.web.public_ip]
  
}