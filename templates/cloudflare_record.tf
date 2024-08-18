####################################################

### Optional 
### For CloudFlare only 

####################################################

data "cloudflare_zone" "this" {
  name = var.domain
}

resource "cloudflare_record" "devopx" {
  zone_id = data.cloudflare_zone.this.id
  name    = "jenkins"
  value   = aws_eip.jenkins_eip.public_ip
  type    = "A"
  proxied = false
}