# Flask DevOps Lab

A fully containerized Flask application deployed on AWS Fargate using Terraform. Designed as a DevOps learning project to demonstrate core concepts including infrastructure as code, container orchestration, and service exposure via Application Load Balancer (ALB).

## Features

- Python Flask app containerized with Docker
- Hosted on AWS ECS Fargate behind a public ALB
- Infrastructure defined and provisioned via Terraform
- Secure network setup using separate security groups for ALB and ECS tasks
- ECR used as private container registry
- CI/CD pipeline using GitHub Actions

## Architecture

- ALB (internet-facing) forwards HTTP traffic to ECS service
- ECS task runs Flask container in public subnet with public IP
- ALB health checks configured on `/` with port 5000
- IAM roles for ECS task execution with logging and pull access
- Docker image stored in private ECR repo

### One-Time Setup (Provision Infrastructure)

```bash
# Initialize Terraform
terraform init
# Optional view changes
terraform plan
# Apply infrastructure
terraform apply
```

After apply completes, retrieve output values:

```bash
terraform output -raw ecr_repo_url
terraform output -raw ecs_cluster_name
terraform output -raw ecs_service_name
```

### Add GitHub Repository Secrets

Go to **GitHub → Settings → Secrets → Actions** and add:

**AWS credentials (used by GitHub Actions):**

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION` (e.g., `ap-southeast-2`)

**Terraform output values:**

- `ECR_REPO_URL` (from `terraform output -raw ecr_repo_url`)
- `ECS_CLUSTER` (from `terraform output -raw ecs_cluster_name`)
- `ECS_SERVICE` (from `terraform output -raw ecs_service_name`)

I created the Output secrets as placeholders and the edited them when I got the values.

## CI/CD with GitHub Actions

This project uses a GitHub Actions workflow to automate deployment on every push to `main`.

- .github/workflows/deploy.yml
- Builds Docker image from `./app`
- Tags image with both `latest` and `YYYY-MM-DD` (date-based version)
- Pushes both tags to Amazon ECR
- Triggers a rolling update of your ECS Fargate service

## Coming Soon

- Nginx reverse proxy for production-style architecture
- PostgreSQL integration or sidecar container
- Health check endpoint (`/health`) in Flask
- DNS integration using Route 53

## Notes

This project simulates a real-world DevOps deployment pipeline using modern AWS tooling. It separates application logic (`/app`) from infrastructure (`/infra`) and leverages GitHub Actions for continuous delivery.
