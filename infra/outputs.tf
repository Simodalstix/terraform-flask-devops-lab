output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = aws_ecr_repository.flask_app_repo.repository_url
}

output "ecs_cluster_name" {
  description = "Name of the ECS Cluster"
  value       = aws_ecs_cluster.main.name
}

output "alb_dns_name" {
  description = "Public DNS name of the Application Load Balancer"
  value       = aws_lb.flask_alb.dns_name
}

output "ecs_task_role_arn" {
  description = "IAM Role ARN for ECS Task Execution"
  value       = aws_iam_role.ecs_task_execution_role.arn
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}
