terraform {
  backend "s3" {
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "terraform_state_lock"
    bucket = "terraformstatebucketsecuringtheawscloud"
  }
}
