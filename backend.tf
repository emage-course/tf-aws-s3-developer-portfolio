terraform {
  backend "s3" {
    bucket         = "website-kendopx-bucket"
    key            = "terra-backend/terraform.tfstate"
    encrypt        = true
    region         = "us-east-2"
    dynamodb_table = "dynamodb-state-locking"
  }
}