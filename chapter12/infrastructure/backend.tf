# locals {
#     s3_bucket_name = ${$Environment.TF_BUCKET}
# }

terraform {
  backend "s3" {
    region         = "us-west-2" # locals.s3_bucket_name
    encrypt        = true
    dynamodb_table = "terraform_state_lock"
    bucket = "arn:aws:s3:::terraformstatebucketsecuringtheawscloud"
    key = "123"
  }
}
