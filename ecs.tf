resource "aws_esc_cluster" "devops" {
  name="terraformdevops"
  setting{
    name="containerInsights"
    value="enabled"
  }
}
resource "aws_esc_task_definition" "name" {
  family="test"
  requires_compatibilities = ["FARGATE"]
  network_mode="awsvpc"
  cpu=256
  memory=512
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "wordpress",
    "image": "wordpress",
    "cpu": 256,
    "memory": 512,
    "essential": true
  }
]
TASK_DEFINITION
}
resource "aws_ecs_service" "wordpress" {
  name="wordpress"
  cluster = aws_ecs_cluster.devops.id
  task_definition = aws_ecs_task_definiton.test.arn
  desired_count = 3
  launch_type     = "FARGATE"
  network_configuration {
      subnets = [module.vpc.public_subnets[0], module.vpc.public_subnets[1], module.vpc.public_subnets[2]]
      security_groups = [aws_security_group.tf-devops.id]
      assign_public_ip = true
    }
}
