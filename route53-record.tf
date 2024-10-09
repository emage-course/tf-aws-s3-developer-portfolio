####################################################

### Optional 
### For CloudFlare only 

####################################################

# data "cloudflare_zone" "this" {
#   name = var.domain
# }

# Create an A record in the hosted zone
resource "aws_route53_record" "emagetech" {
  zone_id    = "Z06639414QTF8GXLZVRH"
  name       = "jenkins"
  type       = "A"
  ttl        = "300"
  records    = [aws_eip.jenkins_eip.public_ip]
  depends_on = [aws_instance.jenkins]
}
