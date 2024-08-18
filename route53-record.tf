####################################################

### Optional 
### For CloudFlare only 

####################################################

# data "cloudflare_zone" "this" {
#   name = var.domain
# }

# Create an A record in the hosted zone
resource "aws_route53_record" "solyspace" {
  zone_id    = "Z05238077JTEPLY1VN0W"
  name       = "jenkins"
  type       = "A"
  ttl        = "300"
  records    = [aws_eip.jenkins_eip.public_ip]
  depends_on = [aws_instance.jenkins]
}
