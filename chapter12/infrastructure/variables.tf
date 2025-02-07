#########################
# VARIABLES
#########################
variable "aws_region" {
  default = "us-west-2"
}

variable "s3_bucket_name" {
  default = "terraformstatebucketsecuringtheawscloud"
}

variable "dynamodb_table_name" {
  default = "terraform_state_lock"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-west-2a", "us-west-2b"]
}