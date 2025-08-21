output "ecr_repository_url" {
  value = aws_ecr_repository.hello_world.repository_url
}

output "ecs_service_name" {
  value = aws_ecs_service.hello_world.name
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "cluster_name" {
  value = aws_ecs_cluster.hello_world.name
}