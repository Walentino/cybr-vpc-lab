

### **Creating IAM Users**
1. **Create an IAM user named Administrator**  
   ```sh
   aws iam create-user --user-name Administrator
   ```
   - This command creates a new IAM user named `Administrator`.

2. **Generate a random password for the user**  
   ```sh
   PASSWORD=$(openssl rand -base64 12)
   ```
   - This stores a randomly generated password in a variable.

3. **Attach AdministratorAccess policy to the user**  
   ```sh
   aws iam attach-user-policy --user-name Administrator --policy-arn arn:aws:iam::aws:policy/AdministratorAccess
   ```
   - Grants full administrative permissions to the `Administrator` user.

4. **Retrieve the AWS account ID**  
   ```sh
   ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)
   ```
   - This command retrieves the AWS account ID and stores it in a variable.

5. **Generate login URL for IAM user**  
   ```sh
   LOGIN_URL=https://${ACCOUNT_ID}.signin.aws.amazon.com/console
   ```
   - This constructs a login URL for the IAM user.

---

### **Creating Another IAM User (Bob)**
6. **Create an IAM user named Bob**  
   ```sh
   aws iam create-user --user-name Bob
   ```
   - Creates an IAM user named `Bob`.

7. **Generate a login profile for Bob with a temporary password**  
   ```sh
   PASSWORD=$(openssl rand -base64 12)
   aws iam create-login-profile --user-name Bob --password "$PASSWORD" --password-reset-required
   ```
   - This generates a password for `Bob` and requires them to reset it upon first login.

8. **Attach specific policies to Bob**  
   ```sh
   aws iam attach-user-policy --user-name Bob --policy-arn arn:aws:iam::aws:policy/AmazonVPCFullAccess
   aws iam attach-user-policy --user-name Bob --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess
   ```
   - These commands grant `Bob` full access to VPC and EC2 resources.

---

### **Creating and Managing IAM User Groups**
9. **Create an IAM user group named Developers**  
   ```sh
   aws iam create-group --group-name Developers
   ```
   - Creates a user group named `Developers`.

10. **Add a user to a group**  
   ```sh
   aws iam add-user-to-group --user-name PowerUser --group-name Developers
   ```
   - Adds `PowerUser` to the `Developers` group.

11. **Attach a policy to a group**  
   ```sh
   aws iam attach-group-policy --group-name Developers --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess
   ```
   - Grants `Developers` group full access to EC2 resources.

12. **Verify user access using access keys**  
   ```sh
   aws iam create-access-key --user-name PowerUser
   ```
   - Generates access keys for `PowerUser`.

13. **Configure AWS CLI with the new user profile**  
   ```sh
   aws configure --profile PowerUserProfile
   ```
   - Sets up CLI profile for `PowerUser` with the generated access key.

14. **Test the permissions by listing VPCs**  
   ```sh
   aws ec2 describe-vpcs --profile PowerUserProfile
   ```
   - Confirms whether `PowerUser` has the expected permissions.

15. **Test denied actions (attempting to list S3 buckets)**  
   ```sh
   aws s3 ls --profile PowerUserProfile
   ```
   - This should return an `AccessDenied` error since `PowerUser` lacks S3 permissions.

16. **List IAM groups**  
   ```sh
   aws iam list-groups
   ```
   - Retrieves all IAM groups in the account.

17. **Remove a user from a group**  
   ```sh
   aws iam remove-user-from-group --user-name PowerUser --group-name Developers
   ```
   - Removes `PowerUser` from the `Developers` group.

18. **Move the user to a new group**  
   ```sh
   aws iam add-user-to-group --user-name PowerUser --group-name Managers
   ```
   - Moves `PowerUser` to `Managers` group.

19. **Attach AdministratorAccess policy to Managers group**  
   ```sh
   aws iam attach-group-policy --group-name Managers --policy-arn arn:aws:iam::aws:policy/AdministratorAccess
   ```
   - Grants full administrative permissions to the `Managers` group.

20. **Detach a policy from a group**  
   ```sh
   aws iam detach-group-policy --group-name Developers --policy-arn arn:aws:iam::aws:policy/AmazonCodeCatalystFullAccess
   ```
   - Removes `AmazonCodeCatalystFullAccess` from `Developers`.

21. **Delete an IAM group**  
   ```sh
   aws iam delete-group --group-name Managers
   ```
   - Deletes the `Managers` group.

---

### **Creating IAM Roles**
22. **Create a trust policy file**  
   ```sh
   nano trust-policy.json
   ```
   - Opens a text editor to create a trust policy.

23. **Create an IAM role for EC2 with S3 access**  
   ```sh
   aws iam create-role --role-name EC2S3FullAccess --assume-role-policy-document file://trust-policy.json
   ```
   - Creates a role named `EC2S3FullAccess` with a trust policy for EC2.

24. **Attach a managed policy to the role**  
   ```sh
   aws iam attach-role-policy --role-name EC2S3FullAccess --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess
   ```
   - Grants the role full access to S3.

25. **Verify the role**  
   ```sh
   aws iam get-role --role-name EC2S3FullAccess
   ```
   - Retrieves role details.

---

### **Creating and Testing IAM Policies**
26. **Create a custom policy file**  
   ```sh
   nano S3ExamplePolicy.json
   ```
   - Opens a text editor to define a policy.

27. **Create a new IAM policy**  
   ```sh
   aws iam create-policy --policy-name S3ExamplePolicy --policy-document file://S3ExamplePolicy.json
   ```
   - Creates a custom policy allowing list and read access to S3.

28. **Create an IAM user for testing**  
   ```sh
   aws iam create-user --user-name S3User
   ```
   - Creates an IAM user named `S3User`.

29. **Attach the custom policy to the user**  
   ```sh
   aws iam attach-user-policy --user-name S3User --policy-arn arn:aws:iam::$ACCOUNT_ID:policy/S3ExamplePolicy
   ```
   - Grants `S3User` limited S3 access.

30. **Generate access keys for the user**  
   ```sh
   aws iam create-access-key --user-name S3User
   ```
   - Generates temporary access credentials for `S3User`.

31. **Configure CLI profile for the new user**  
   ```sh
   aws configure --profile S3UserProfile
   ```
   - Configures CLI profile with new credentials.

32. **Verify S3 list access (allowed)**  
   ```sh
   aws s3 ls --profile S3UserProfile
   ```
   - Lists S3 buckets.

33. **Attempt to delete an object (denied)**  
   ```sh
   aws s3 rm s3://bucket-name/object --profile S3UserProfile
   ```
   - Should return an `AccessDenied` error.

34. **List access keys for cleanup**  
   ```sh
   aws iam list-access-keys --user-name S3User
   ```
   - Lists access keys assigned to `S3User`.

35. **Delete access keys**  
   ```sh
   aws iam delete-access-key --user-name S3User --access-key-id <AccessKeyId>
   ```
   - Removes temporary credentials.
