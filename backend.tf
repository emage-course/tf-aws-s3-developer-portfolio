terraform {
  backend "s3" {
    bucket         = "tf-remote-backend-state-lab20231114133906936800000001"
    key            = "terra-backend/terraform.tfstate"
    encrypt        = true
    region         = "us-east-2"
    dynamodb_table = "dynamodb-state-locking"
  }
}