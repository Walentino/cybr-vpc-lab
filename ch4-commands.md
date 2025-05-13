
# Chapter 4 - AWS Identity Center Command Cheatsheet

Replace placeholder values like `<EMAIL>` or `<OU_ID>` with values from your environment.

---

## Create an AWS Organization
```bash
aws organizations create-organization
```

## Get Root ID
```bash
aws organizations list-roots --query 'Roots[0].Id' --output text
```

## Create Organizational Units (OUs)
```bash
aws organizations create-organizational-unit --parent-id <ROOT_ID> --name "Dev Accounts"
aws organizations create-organizational-unit --parent-id <ROOT_ID> --name "Production Accounts"
```

## Create Accounts
```bash
aws organizations create-account --email <EMAIL> --account-name "Security 101 Dev"
aws organizations create-account --email <EMAIL> --account-name "Security 101 Prod"
aws organizations create-account --email <EMAIL> --account-name "Security 101 Primary"
```

## Move Accounts into OUs
```bash
aws organizations move-account --account-id <ACCOUNT_ID> --source-parent-id <ROOT_ID> --destination-parent-id <OU_ID>
```
