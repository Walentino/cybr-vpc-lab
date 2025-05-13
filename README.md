
# Securing the AWS Cloud

Welcome to the official companion repository for the book **"Securing the AWS Cloud"** by Brandon Carroll.

If you're reading this, you're probably digging into AWS security and looking for a hands-on, real-world way to apply what you’re learning. You're in the right place.

This repository contains all the **code examples, CloudFormation templates, CLI commands, automation scripts, and supporting files** referenced throughout the book — organized by chapter for easy access and use.

---

## ⚠️ Important Notice

This repository and its contents are provided **AS-IS** for educational purposes. Use of any provided templates, scripts, or commands in a production environment is **strongly discouraged unless properly tested and validated**.

You are responsible for all actions taken in your AWS account. **Always perform cleanup** of resources when you're done to avoid unexpected charges. Shell scripts and templates in this repository may create billable resources including EC2 instances, S3 buckets, IAM roles, CloudWatch logs, and more.

> ⚠️ **USE AT YOUR OWN RISK.** Always double-check AWS charges and IAM permissions before deploying anything in a live environment.

---

## 📂 Repository Structure

Each chapter of the book has a corresponding folder in this repository. Inside each folder, you'll find the following:

- `chapterX-commands.md` — CLI command cheatsheet for the chapter
- `chapterX-resources-created.md` — A list of AWS resources created and used
- `chapterX-cleanup.sh` — Shell script to tear down AWS resources *(use with caution)*
- `chapterX-initial.yml` — CloudFormation template representing the starting state
- `chapterX-final.yml` — CloudFormation template representing the completed infrastructure

> Not all chapters use CloudFormation. Some chapters rely exclusively on **Terraform** or **manual configuration**, in which case placeholder files are included.

---

### Chapters Overview

| Chapter | Topic | Highlights |
|--------|-------|------------|
| `chapter1/` | Introduction to Cloud Security | Basic console orientation |
| `chapter2/` | AWS Security Fundamentals | IAM, KMS, CloudTrail, GuardDuty |
| `chapter3/` | Identity and Access Management | IAM users, groups, policies |
| `chapter4/` | AWS IAM Identity Center | Organizational Units, user federation |
| `chapter5/` | Infrastructure Protection | VPC, security groups, NACLs |
| `chapter6/` | Threat Detection | GuardDuty + automation with Lambda |
| `chapter7/` | Data Security and Cryptography | KMS, secure S3 buckets |
| `chapter8/` | Monitoring & Compliance | Flow logs, alarms, CloudTrail |
| `chapter9/` | Resilience & Recovery | AWS Backup, cross-region vaults |
| `chapter10/` | Security Automation | GuardDuty > EventBridge > Lambda |
| `chapter11/` | Developer Mindset & Security as Code | IaC, cfn-guard, Checkov |
| `chapter12/` | GitOps for AWS Infrastructure | Terraform + GitHub Actions + OIDC |

---

## 🧠 How to Use This Repository

1. **Clone the Repo**
   ```bash
   git clone https://github.com/8carroll/Securing-the-Cloud-with-Brandon-Carroll.git
   cd Securing-the-Cloud-with-Brandon-Carroll
   ```

2. **Navigate to the Chapter You're Reading**
   ```bash
   cd chapter6/
   ```

3. **Deploy the Initial Environment**
   Use `chapterX-initial.yml` or `terraform apply` depending on the chapter.

4. **Follow Along with the Commands**
   Open `chapterX-commands.md` and run each command in your terminal.

5. **Review the Resources**
   Check `chapterX-resources-created.md` for what’s being provisioned.

6. **Clean Up**
   Run `chapterX-cleanup.sh` or manually destroy your infrastructure.
   > ⚠️ **Double-check** before running cleanup scripts. Many of them use `--force` flags and can delete resources immediately.

---

## 🧪 Testing & Verification

Before applying any automation in your own environments:
- Review IAM policies and roles in detail.
- Validate templates using `cfn-lint` or `terraform validate`.
- Run static analysis with tools like `Checkov`, `cfn-nag`, or `Snyk`.

If using GitHub Actions, ensure you:
- Store secrets securely using GitHub repository secrets
- Limit permissions granted to IAM roles used by workflows

---

## 📬 Stay Connected

Security isn’t a checkbox — it’s a continuous process. I’d love to hear about how you're applying what you’ve learned:

- 🔗 [Connect with me on LinkedIn](https://linkedin.com/in/brandoncarroll)
- 📬 [Subscribe to my newsletter, *Securing the Cloud*](https://brandoncarroll.substack.com)
- 🧠 [Follow @CloudSecurityGuy on TikTok for bite-sized tips]

---

## 🤝 Contributing

Spotted a typo? Found a better way to automate something? Want to contribute a real-world example?

- 📂 Fork the repository
- 🛠️ Make your changes
- 📥 Submit a pull request

You can also open issues or discussions to ask questions or suggest improvements.

---

## 📝 License

This project is licensed under the MIT License — see the `LICENSE.md` file for details.

---

## ✅ Final Notes

- **You are responsible** for your own AWS account usage and billing.
- Every resource created in these examples should be **manually validated and monitored**.
- These examples are intended for **learning and testing**, not production use.

---

Happy Labbing! 🚀  
*“Security is not a product, but a process.”* — Bruce Schneier
