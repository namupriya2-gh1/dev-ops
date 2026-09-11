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

## 🛠️ Manual CLI Operations & Troubleshooting Cheat Sheet
Below are the standalone commands used during testing to explore networks, build user policies, debug architecture failures, and tear down assets.

### 1. Identity & Access Management (IAM)
* **Create a user profile:**
  ```bash
  aws iam create-user --user-name intern-dev
  ```
* **Rename a user and instantly view validation details:**
  ```bash
  aws iam update-user --user-name instern-dev --new-user-name intern-dev; aws iam get-user --user-name intern-dev
  ```
* **List all identities in clean table outputs via filtering:**
  ```bash
  aws iam list-users --query "Users[*].{Name:UserName,ID:UserId}" --output table
  ```

### 2. Networking & Diagnostics
* **Isolate active Subnet IDs and associated VPC networks:**
  ```bash
  aws ec2 describe-subnets --query "Subnets[*].[SubnetId,VpcId]" --output table
  ```
* **Audit Security Group VPC mappings to isolate cross-network mismatches:**
  ```bash
  aws ec2 describe-security-groups --group-ids sg-07cc841ae5b06bf16 --query "SecurityGroups[*].VpcId" --output text
  ```
* **Provision custom VPC Subnets with tailored CIDR blocks:**
  ```bash
  aws ec2 create-subnet --vpc-id vpc-0a5a8e5e6a586998c --cidr-block 10.0.1.0/24 --query "Subnet.SubnetId" --output text
  ```

### 3. CloudFormation Automation & Financial Teardown
* **Deploy an infrastructure stack using local absolute file systems:**
  ```bash
  aws cloudformation create-stack --stack-name dev-environment --template-body file:///Users/Namusuresh/Documents/Dev-ops/template.yaml
  ```
* **Track stack build cycles live:**
  ```bash
  aws cloudformation describe-stack-events --stack-name dev-environment --query "StackEvents[*].[ResourceStatus,ResourceType,LogicalResourceId]" --output table
  ```
* **Tear down automated resource environments safely:**
  ```bash
  aws cloudformation delete-stack --stack-name dev-environment
  ```
* **Terminate multiple compute instances simultaneously to prevent running charges:**
  ```bash
  aws ec2 terminate-instances --instance-ids i-0f558ad239d18952f i-0786409289162dbaf i-0bc48504efc84b733
  ```

---

### 🚨 Crucial Security Rule
**NEVER git commit your AWS Access Keys, Secret Keys, or your `.pem` keys into GitHub.** This script assumes the operator has already securely configured credentials locally via `aws configure`.
