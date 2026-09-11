# AWS Cloud Infrastructure & Automation Lab

A practical DevOps engineering project focused on provisioning secure network topologies, identity access controls (IAM), and automated deployment workflows using the AWS CLI and CloudFormation.

## 🛠️ Skills Demonstrated
- **Automation & Scripting:** Authored modular Bash scripts to dynamically orchestrate compute resources.
- **Infrastructure as Code (IaC):** Automated cloud infrastructure builds using CloudFormation templates.
- **Networking & VPC Design:** Provisioned isolated custom Subnets (`10.0.1.0/24`) and handled dynamic JMESPath target queries.
- **Security & IAM:** Configured firewall layers by deploying custom security groups, managing explicit ingress rules, and controlling identity lifecycles.

## 🚀 Script 1: Automated EC2 Web Server Environment
Located in `phase1-compute/deploy-ec2-env.sh`, this shell script completely automates the infrastructure setup:
1. Dynamically queries and retrieves the active default VPC ID.
2. Creates a structural firewall (Security Group).
3. Injects inbound rules allowing explicit traffic for HTTP (80) and SSH (22).
4. Launches a free-tier compliant `t3.micro` compute instance attached to the firewall.

### How to execute it:
```bash
chmod +x phase1-compute/deploy-ec2-env.sh
./phase1-compute/deploy-ec2-env.sh
```

---

### 🚨 Crucial Security Rule
**NEVER git commit your AWS Access Keys, Secret Keys, or your `.pem` keys into GitHub.** This script assumes the operator has already securely configured credentials locally via `aws configure`.
