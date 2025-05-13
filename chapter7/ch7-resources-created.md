
# Chapter 7 – Resources Created

---

## KMS

- KMS Key: `<KEY_ID>`
- Key Description: "Key for processing payroll data"
- Key Tags:
  - Department: Payroll

## IAM

- Role: `PayrollKeyAdmin`
- Role: `PayrollKeyUser`

## S3

- Bucket: `secure-customer-data-*`
- Tags:
  - DataClassification: Confidential
  - Department: Finance
- Bucket Policy: Enforces KMS encryption
