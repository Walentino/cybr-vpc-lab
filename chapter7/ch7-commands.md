
# Chapter 7 - Data Security and Cryptography Command Cheatsheet

---

## Create a Secure S3 Bucket with Tags
```bash
BUCKET_NAME="secure-customer-data-${RANDOM}"

aws s3api create-bucket \
  --bucket ${BUCKET_NAME} \
  --region us-west-2 \
  --create-bucket-configuration LocationConstraint=us-west-2

aws s3api put-bucket-tagging \
  --bucket ${BUCKET_NAME} \
  --tagging 'TagSet=[{Key=DataClassification,Value=Confidential},{Key=Department,Value=Finance}]'
```

## Enforce Encryption with Bucket Policy
```bash
aws s3api put-bucket-policy \
  --bucket ${BUCKET_NAME} \
  --policy file://bucket-policy.json
```

## Create a KMS Key
```bash
aws kms create-key \
  --description "Key for processing payroll data" \
  --tags TagKey=Department,TagValue=Payroll
```

## Create IAM Trust Policy
```bash
cat << EOF > trust-policy.json
{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Principal": { "Service": "ec2.amazonaws.com" },
    "Action": "sts:AssumeRole"
  }]
}
EOF
```

## Create IAM Roles
```bash
aws iam create-role --role-name PayrollKeyAdmin --assume-role-policy-document file://trust-policy.json
aws iam create-role --role-name PayrollKeyUser --assume-role-policy-document file://trust-policy.json
```

## Create and Attach Key Policy
```bash
aws kms put-key-policy \
  --key-id <KEY_ID> \
  --policy-name default \
  --policy file://key-policy.json
```

## Encrypt and Decrypt a File
```bash
echo "Sensitive payroll data" > payroll.txt

aws kms encrypt \
  --key-id <KEY_ID> \
  --plaintext fileb://payroll.txt \
  --output text --query CiphertextBlob | base64 --decode > payroll.encrypted

aws kms decrypt \
  --ciphertext-blob fileb://payroll.encrypted \
  --output text --query Plaintext | base64 --decode > payroll.decrypted
```
