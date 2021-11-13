resource "aws_route53_record" "www" {
  zone_id =  "Z04351853NLZ745NKF1C"
  name    = "blog.isolebo365.com"
  type    = "A"
  ttl     = "300"
  records  = ["127.0.0.1"]
  
}