# Chapter 3 - Identity and Access Management (IAM)

This folder contains two key files related to the IAM configurations and cleanup process covered in Chapter 3 of the book.

## Files in this Folder

### `ch3-commands.md`
This file contains a list of all AWS CLI commands used in Chapter 3, along with explanations of what each command does. It serves as a reference for:
- Creating IAM users, groups, roles, and policies.
- Attaching permissions to users and groups.
- Managing IAM identities and verifying access.
- Setting up IAM roles for EC2 instances.
- Creating and testing custom IAM policies.

If you need a step-by-step guide on how to execute IAM-related AWS CLI commands, refer to this file.

### `ch3-cleanup.sh`
This is a Bash script that automates the cleanup of all IAM resources created in Chapter 3. It:
1. **Detaches policies** from IAM users, groups, and roles.
2. **Deletes access keys** associated with users.
3. **Removes IAM users** and IAM groups.
4. **Deletes IAM roles and custom policies.**

#### How to Run the Cleanup Script
To execute the cleanup process, run the following command in AWS CloudShell or any terminal with AWS CLI configured:
```sh
bash ch3-cleanup.sh
