####################################################

### Optional

####################################################

# Route 53 A Record for Website
resource "aws_route53_record" "solomon" {
  zone_id = "Z06639414QTF8GXLZVRH"
  name    = "solomon" # Replace with your subdomain
  type    = "A"
  alias {
    # name = aws_s3_bucket.bucket.bucket_domain_name
    name                   = aws_cloudfront_distribution.distribution.domain_name
    zone_id                = aws_cloudfront_distribution.distribution.hosted_zone_id
    evaluate_target_health = true
  }
}
