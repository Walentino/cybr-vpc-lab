
# Chapter 11 - Developer Mindset & Security as Code Command Cheatsheet

---

## Install IaC Tools

### Install Terraform (macOS via Homebrew)
```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
terraform -help
```

### Install cfn-guard (CloudFormation Guard)
```bash
brew install cfn-guard
```

---

## Example IaC Commands

### Deploy CloudFormation Template
```bash
aws cloudformation deploy \
  --template-file secure-s3.yml \
  --stack-name secure-s3-stack \
  --capabilities CAPABILITY_NAMED_IAM
```

### Scan CloudFormation Template with cfn-nag
```bash
cfn_nag_scan --input-path secure-s3.yml
```

### Scan Terraform Code with Checkov
```bash
checkov -d .
```

---

## Version Control and GitOps

### Rollback to a Previous Commit (Git)
```bash
git log
git checkout <COMMIT_HASH>
```

### Validate IaC Configs Before Merge (GitHub Actions Example)
```yaml
jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run Checkov
        uses: bridgecrewio/checkov-action@master
        with:
          directory: ./
```
