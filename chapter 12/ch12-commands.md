
# Chapter 12 - GitOps for AWS Infrastructure Command Cheatsheet

---

## S3 Bucket for Terraform State
```bash
aws s3api create-bucket \
  --bucket terraformstatebucketsecuringtheawscloud \
  --region us-west-2 \
  --create-bucket-configuration LocationConstraint=us-west-2

aws s3api put-bucket-versioning \
  --bucket terraformstatebucketsecuringtheawscloud \
  --versioning-configuration Status=Enabled
```

## DynamoDB for State Locking
```bash
aws dynamodb create-table \
  --table-name terraform_state_lock \
  --billing-mode PAY_PER_REQUEST \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH
```

## Verify S3 Bucket Public Access Block
```bash
aws s3api get-public-access-block --bucket terraformstatebucketsecuringtheawscloud
```

## OIDC Provider (Manual via Console Recommended)

## GitHub Setup
- Create repository secrets:
  - `AWS_IAM_ROLE`
  - `TF_STATE_BUCKET`
