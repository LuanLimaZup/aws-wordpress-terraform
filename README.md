# AWS WordPress Infrastructure with Terraform

Production-style AWS infrastructure for scalable WordPress hosting using Terraform modules.

## Overview

This project provisions a highly available and scalable WordPress infrastructure on AWS using Infrastructure as Code (IaC) principles with Terraform.

The environment includes networking, load balancing, auto scaling, shared storage, CDN, WAF protection and monitoring resources following modular architecture practices.

## Architecture

### Main AWS Services Used

* VPC
* Public and Private Subnets
* Internet Gateway
* NAT Gateway
* Route Tables
* Application Load Balancer (ALB)
* Auto Scaling Group (ASG)
* Launch Template
* EC2
* EFS
* RDS MySQL
* CloudFront
* AWS WAF
* Route 53
* IAM
* CloudWatch

---

## Infrastructure Features

### Networking

* Custom VPC
* Multi-AZ architecture
* Public and private subnets
* Internet and NAT gateways
* Route table separation

### Compute

* EC2 instances managed by Auto Scaling Group
* Launch Template with automated WordPress installation
* Apache + PHP configuration via user_data

### Storage

* Shared EFS storage for WordPress files
* RDS MySQL database

### Security

* Modular Security Groups
* WAF protection with AWS Managed Rules
* HTTPS support with ACM
* Private RDS deployment

### Scalability & Availability

* Auto Scaling Group
* Multi-AZ deployment
* Application Load Balancer
* CloudFront CDN

### Monitoring

* CloudWatch CPU alarms
* Infrastructure tagging strategy

---

# Terraform Modules

The infrastructure was refactored into reusable Terraform modules:

```text
modules/
├── alb/
├── auto-scaling-group/
├── cloudfront/
├── efs/
├── launch-template/
├── security-group/
├── vpc/
└── waf/
```

---

# CI/CD

GitHub Actions pipeline configured to validate Terraform code automatically:

* terraform fmt
* terraform validate

---

# Git Workflow

This project follows a professional Git workflow using:

* Feature branches
* Pull Requests
* Merge strategy
* Commit history organization

Example:

```text
main
└── refactor-more-modules
```

---

# Project Structure

```text
.
├── modules/
├── main.tf
├── provider.tf
├── variables.tf
├── locals.tf
├── cloudwatch.tf
├── rds.tf
├── route-53.tf
└── README.md
```

---

# How to Deploy

## Initialize Terraform

```bash
terraform init
```

## Validate Configuration

```bash
terraform validate
```

## Review Infrastructure Plan

```bash
terraform plan
```

## Apply Infrastructure

```bash
terraform apply
```

---

# Future Improvements

* Docker containerization
* Kubernetes / EKS
* Helm Charts
* CI/CD deployment pipeline
* Datadog integration
* Blue/Green deployment strategy

---

# Author

Luan Gomes

GitHub:
https://github.com/LuanLimaZup
