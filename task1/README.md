# AWS Infrastructure Deployment using Terraform

This project provisions a highly available AWS infrastructure using Terraform.  
It includes networking, compute, security, Jenkins setup, and S3 storage.

---

## Architecture Overview
                         Internet
                            │
                     ┌──────┴──────┐
                     │   ALB       │
                     │  (Public)   │
                     └──────┬──────┘
                            │
        ┌───────────────────┼───────────────────┐
        │                                       │
  Public Subnet A                         Public Subnet B
   - NAT Gateway                            - Jenkins Master
        │
        │ (Outbound Internet via NAT)
        ▼
  Private Subnet A                     Private Subnet B
   - App Server                          - App Server
   - Jenkins Agent


Additional AWS Services:
- S3 (Terraform Remote State + Build Artifacts)
- IAM Roles & Instance Profiles (Least Privilege)
- Security Groups
- Route Tables (Public & Private)

---

## Infrastructure Components

### 1. Networking
- Custom VPC
- 2 Public Subnets (Multi-AZ)
- 2 Private Subnets (Multi-AZ)
- Internet Gateway
- NAT Gateway
- Public & Private Route Tables

### 2. Security
- Security Groups:
  - ALB (HTTP/HTTPS from internet)
  - App (traffic only from ALB)
  - Jenkins (controlled access)
- IAM Roles with least-privilege access
- Optional DynamoDB for Terraform state locking

### 3. Compute
- EC2 Application Servers (Private Subnets)
- Jenkins Master (Public Subnet)
- Jenkins Agent (Private Subnet)
- Instance Profiles attached for S3 access

### 4. Storage
- S3 Bucket
  - Terraform Remote State
  - Artifact Storage
  - Versioning Enabled
  - Encryption Enabled

---

## Variables and Defaults

| Variable | Description | Default |
|-----------|------------|----------|
| region | AWS region | ap-south-1 |
| vpc_cidr | VPC CIDR block | 10.0.0.0/16 |
| public_subnet_cidrs | Public subnet CIDRs | 10.0.1.0/24, 10.0.2.0/24 |
| private_subnet_cidrs | Private subnet CIDRs | 10.0.3.0/24, 10.0.4.0/24 |
| instance_type | EC2 instance type | t3.micro |
| environment | Environment name | dev |
| key_name | EC2 Key Pair | null |

Override using:
- `terraform.tfvars`
or
- `terraform apply -var="instance_type=t3.small"`

---

## Project Structure

├── backend.tf
├── main.tf
├── variables.tf
├── versions.tf
├── outputs.tf
├── terraform.tfvars
└── README.md


---

## How to Use

### 1. Configure AWS Credentials
Use IAM user credentials (recommended) or configure via:
aws configure


---

### 2. Initialize Terraform

terraform init

---

### 3. Validate & Plan

terraform validate
terraform plan


---

### 4. Deploy Infrastructure

terraform apply


Confirm with:

yes


---

### 5. Destroy Infrastructure

terraform destroy


---

## Best Practices Implemented

- Multi-AZ high availability
- Private application tier
- NAT-based secure outbound access
- Separate Jenkins Master & Agent
- Remote state support (S3 + DynamoDB)
- Infrastructure fully reproducible
- Least-privilege IAM policies

---

## Notes

- Do not use root credentials in production.
- Enable S3 versioning for Terraform state.
- Enable DynamoDB locking to prevent state conflicts.
- Keep secrets out of Terraform code.

---

Provisioned using Terraform (IaC)  
Designed following AWS production architecture principles.