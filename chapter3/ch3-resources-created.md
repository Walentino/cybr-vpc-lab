Here is a **list of all AWS resources created in Chapter 3**, categorized by type:

---

### **IAM Users**
1. **Administrator** - Full access to AWS services.
2. **Bob** - Has limited permissions, with access to VPC and EC2.
3. **PowerUser** - Initially part of the Developers group.
4. **S3User** - Has restricted permissions, only allowing S3 bucket listing and object retrieval.

---

### **IAM Groups**
1. **Developers** - Grants EC2 full access.
2. **Managers** - Grants Administrator access.

---

### **IAM Roles**
1. **EC2S3FullAccess** - 
   - Trusted by **EC2** service.
   - Grants full access to all S3 buckets.

---

### **IAM Policies**
1. **AdministratorAccess (AWS Managed Policy)** - Attached to `Administrator` user.
2. **AmazonVPCFullAccess (AWS Managed Policy)** - Attached to `Bob` user.
3. **AmazonEC2FullAccess (AWS Managed Policy)** - Attached to `Bob` user.
4. **AmazonEC2FullAccess (AWS Managed Policy)** - Attached to `Developers` group.
5. **AdministratorAccess (AWS Managed Policy)** - Attached to `Managers` group.
6. **AmazonS3FullAccess (AWS Managed Policy)** - Attached to `EC2S3FullAccess` role.
7. **Custom IAM Policy (S3ExamplePolicy)** - Allows `S3User` to list and read S3 objects.

---

### **IAM Group Memberships**
- **PowerUser** is added to the `Developers` group.
- **S3User** is added to the `Developers` group.
- **PowerUser** is later moved to the `Managers` group.

---

### **Other Resources**
- **IAM Login Profile for Bob** (temporary password setup).
- **Access Keys for IAM Users** (PowerUser and S3User, for API access).

