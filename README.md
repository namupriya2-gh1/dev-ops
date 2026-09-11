# AWS Cloud Infrastructure & Automation Lab

A practical DevOps engineering project focused on provisioning secure network topologies, identity access controls (IAM), and automated deployment workflows using the AWS CLI and CloudFormation.

## 🛠️ Skills Demonstrated
- **Infrastructure as Code (IaC):** Automated cloud infrastructure builds using CloudFormation templates.
- **Networking & VPC Design:** Provisioned isolated custom Subnets (`10.0.1.0/24`) and resolved cross-VPC communication conflicts.
- **Security & IAM:** Configured granular access control by deploying custom security groups, creating isolated users, and managing identity life cycles.
- **Cost Engineering & Monitoring:** Implemented a `ZeroSpendBudget` safety layer to monitor resource spend metrics.

## 📐 Architecture Components Mastered
- **Automation Engine:** AWS CloudFormation Stacks
- **Network Stack:** Isolated Virtual Private Clouds (VPCs) with tailored subnets
- **Compute layer:** Elastic Compute Cloud (EC2) `t3.micro` instances
- **Data Filtering:** Advanced CLI optimization using `--query` filtering strings
