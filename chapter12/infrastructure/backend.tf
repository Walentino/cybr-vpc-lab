#############################
# TERRAFORM BACKEND (S3 + DDB)
#############################
terraform {
  backend "s3" {
    bucket         = "terraformstatebucketsecuringtheawscloud"
    key            = "network-firewall/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "terraform_state_lock"
  }
}
