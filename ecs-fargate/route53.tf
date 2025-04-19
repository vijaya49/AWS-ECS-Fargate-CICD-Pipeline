resource "aws_route53_record" "app_cname" {
  zone_id = var.hosted_zone_id
  name    = var.domain_name
  type    = "CNAME"
  ttl     = 60
  records = [aws_lb.main.dns_name]
}
