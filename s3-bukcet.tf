# Create a new S3 bucket for Jenkins artifacts
/*The aws_s3_bucket resource defines an S3 bucket that will be used to store Jenkins artifacts. The bucket will be named jenkins-
artifacts-s3bucket-jason2023 and will have a private ACL.
*/

resource "aws_s3_bucket" "jenkins_artifacts_bucket" {
  bucket = "jenkins-s3bucket-demo01" # Set a unique bucket name
}

