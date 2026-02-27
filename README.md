🌐 Enterprise 3-Tier Architecture on AWS (Terraform)
📌 Overview

This open-source project provisions a production-ready 3-tier application architecture on AWS using Terraform with a modular design.

It demonstrates how enterprise teams design secure, scalable, and observable cloud infrastructure using Infrastructure as Code (IaC).

🏗️ Architecture
<img width="913" height="598" alt="image" src="https://github.com/user-attachments/assets/72e056a3-e8a4-449a-95d0-00dd9dee9879" />

Internet
   |
   v
Application Load Balancer (Public Subnets)
   |  HTTP (HTTPS-ready)
   |
Auto Scaling Group (EC2 - Private Subnets)
   |  Dockerized NGINX
   |
Amazon RDS (MySQL - Multi-AZ, Private)
   |
AWS Secrets Manager (DB Credentials)

CloudWatch Alarms → Auto Scaling Policies
🧱 Services Used
Category	Services
IaC	Terraform (Modules)
Networking	VPC, Public & Private Subnets
Load Balancing	Application Load Balancer
Compute	EC2 + Auto Scaling Group
Application	NGINX (Docker)
Database	Amazon RDS MySQL (Multi-AZ)
Secrets	AWS Secrets Manager
Monitoring	CloudWatch Alarms
Security	Security Groups, Private Networking
TLS	HTTPS-ready via ACM (optional)
📂 Repository Structure
terraform-3tier-modules/
├── modules/
│   ├── vpc/          # VPC, subnets, routing
│   ├── alb/          # ALB, listeners (HTTP / HTTPS-ready)
│   ├── asg/          # Launch Template & Auto Scaling Group
│   ├── rds/          # RDS + Secrets Manager
│   ├── cloudwatch/   # Scaling policies & alarms
│
├── env/
│   └── dev/
│       └── terraform.tfvars
│
├── main.tf
├── variables.tf
├── outputs.tf
├── backend.tf        # Remote state (S3 + DynamoDB)
└── README.md
🔐 Security Best Practices

✅ No plaintext database passwords

✅ Credentials stored in AWS Secrets Manager

✅ EC2 instances run in private subnets

✅ RDS is not publicly accessible

✅ ALB is the only public entry point

✅ HTTPS support integrated (toggle-based)

📈 Scalability & Reliability

Auto Scaling Group (min / max / desired)

CPU-based scale-in and scale-out

ALB health checks

Multi-AZ RDS for high availability

🚀 Deployment
terraform init
terraform validate
terraform plan -var-file=env/dev/terraform.tfvars
terraform apply
🌐 Accessing the Application

After deployment, Terraform outputs:

ALB DNS Name

RDS Endpoint

Access the application:

http://<alb-dns-name>

Expected output:

NGINX Welcome Page

🔮 Roadmap

🔐 Enable HTTPS with ACM

🛡️ Add AWS WAF to ALB

🚀 GitHub Actions CI/CD pipeline

📊 Enhanced monitoring & alerts

🔄 Blue/Green or rolling deployments

🧠 Interview-Ready Explanation

“This project showcases how to design enterprise-grade AWS infrastructure using Terraform modules, with a strong focus on security, scalability, and operational best practices.”

🏆 Why This Project Matters

Real enterprise architecture (not a lab demo)

Modular, reusable Terraform design

Secure secrets handling

Production-style scaling & monitoring

Ideal for DevOps / Cloud Engineer portfolios

🤝 Contributing

Contributions are welcome!

Fork the repository

Create a feature branch

Submit a pull request

📄 License

This project is licensed under the MIT License.

👤 Author

Murali Krishna
Cloud & DevOps Engineer
AWS • Terraform • Automation
