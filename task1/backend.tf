terraform {
backend "s3" {
    bucket         = "dev-terraform-state-bucket-shrey"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}