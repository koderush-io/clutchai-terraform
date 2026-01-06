To deploy AWS Aurora Serverless v2 with IAM Authentication, Secrets Manager, and initial SQL scripts, we will use a combination of standard Terraform resources and a null_resource to handle the schema creation.

1. The Core Infrastructure (Aurora & Secrets Manager)
This script sets up a VPC-restricted Aurora cluster where the password is automatically generated and stored in Secrets Manager. 
- `core-infra.tf`

2. IAM Role for Application Access
You requested an IAM role that applications can use to connect. This role uses IAM Authentication, meaning your app doesn't need a password to connect—it uses a temporary token.
- `iam-role.tf`

3. Running Initial SQL Scripts
Terraform does not natively manage SQL tables. The standard "DevOps" way to do this within Terraform is using a null_resource with a local-exec provisioner.
- `initial-sql.tf`

Note: This requires psql to be installed on the machine running Terraform and needs network access to the VPC (typically run from a CI/CD runner inside the VPC or via a VPN).

4. VPC Security (Restricted Access)
The Security Group ensures only traffic from within your VPC (specifically from your application's security group) can reach the database.
- `vpc-security.tf`