terraform {
  backend "s3" {
    bucket         = "cisco-ricardo-terraform-state-bucket "
    key            = "ci/aws/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "cisco-ricardo-terraform-state-lock"
    encrypt        = true
  }
}

