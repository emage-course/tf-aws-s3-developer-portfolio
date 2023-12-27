# terraform {
#   backend "s3" {
#     bucket         = "terraform-state-lab-demo-01"
#     key            = "terra-backend/terraform.tfstate"
#     encrypt        = true
#     region         = "us-east-2"
#     dynamodb_table = "dynamodb-state-locking"
#   }
# }