resource "aws_ecs_cluster" "onlyflights-ecs" {
  name = "OnlyFlights"
  capacity_providers = ["FARGATE"]
}

# resource "aws_ecs_task_definition" "onlyflights-ecs-task" {
#   family = "onlyflights-webapp"
#   container_definitions = <<TASK_DEFINITION
# [
#   {
#     "name": "flaskapp",
#     "image": "153658864904.dkr.ecr.eu-central-1.amazonaws.com/onlyflgihts-ecr:latest",
#     "cpu": 0,
#     "links": [

#     ],
#     "portMappings": [
#       {
#         "name": "flaskapp-80-tcp",
#         "containerPort": 80,
#         "hostPort": 80,
#         "protocol": "tcp",
#         "appProtocol": "http"
#       }
#     ],
#     "essential": true,
#     "entryPoint": [

#     ],
#     "command": [

#     ],
#     "environment": [

#     ],
#     "environmentFiles": [

#     ],
#     "mountPoints": [

#     ],
#     "volumesFrom": [

#     ],
#     "secrets": [

#     ],
#     "dnsServers": [

#     ],
#     "dnsSearchDomains": [

#     ],
#     "extraHosts": [

#     ],
#     "dockerSecurityOptions": [

#     ],
#     "dockerLabels": {

#     },
#     "ulimits": [

#     ],
#     "logConfiguration": {
#       "logDriver": "awslogs",
#       "options": {
#         "awslogs-create-group": "true",
#         "awslogs-group": "/ecs/onlyflights-webapp",
#         "awslogs-region": "eu-central-1",
#         "awslogs-stream-prefix": "ecs"
#       },
#       "secretOptions": [

#       ]
#     },
#     "systemControls": [

#     ]
#   }
# ]
# TASK_DEFINITION

#   task_role_arn = "arn:aws:iam::153658864904:role/ecsTaskExecutionRole"
#   execution_role_arn = "arn:aws:iam::153658864904:role/ecsTaskExecutionRole"
#   requires_compatibilities = ["FARGATE"]
#   network_mode = "awsvpc"
#   cpu = 1024
#   memory = 3072
  
#   ephemeral_storage {
#     size_in_gib = 21
#   }
  
#   runtime_platform {
#     cpu_architecture = "X86_64"
#     operating_system_family = "LINUX"
#   }

#   tags = {
#     key = "ecs:taskDefinition:createdFrom"
#     value = "ecs-console-v2"
#   }
# }


# resource "aws_ecs_service" "onlyflights-service" {
#   name = "OnlyFlights-Service"
#   cluster = "${aws_ecs_cluster.onlyflights-ecs.id}"
#   launch_type = "FARGATE"
#   platform_version = "LATEST"
#   task_definition = "${aws_ecs_task_definition.onlyflights-ecs-task.arn}"
#   desired_count = 2
  
#   network_configuration {
#     subnets = ["${aws_subnet.fargate-subnet-1a.id}", "${aws_subnet.fargate-subnet-1b.id}"]
#     security_groups = ["${aws_security_group.elb-security-group.id}"]
#     assign_public_ip = true
#   }

#   load_balancer {
#     target_group_arn = "${aws_lb_target_group.onlyflights-ip-target-group.arn}"
#     container_name = "flaskapp"
#     container_port = 80
#   }

# }

# resource "aws_appautoscaling_target" "onlyflights-autoscaling" {
#     max_capacity = 5
#     min_capacity = 2
#     resource_id = "service/${aws_ecs_cluster.onlyflights-ecs.name}/${aws_ecs_service.onlyflights-service.name}"
#     scalable_dimension = "ecs:service:DesiredCount"
#     service_namespace  = "ecs"
# }

# resource "aws_appautoscaling_policy" "ecs_policy" {
#   name               = "onlyflights-autoscaling"
#   policy_type        = "TargetTrackingScaling"
#   resource_id        = "${aws_appautoscaling_target.onlyflights-autoscaling.resource_id}"
#   scalable_dimension = "${aws_appautoscaling_target.onlyflights-autoscaling.scalable_dimension}"
#   service_namespace  = "${aws_appautoscaling_target.onlyflights-autoscaling.service_namespace}"

#   target_tracking_scaling_policy_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "ALBRequestCountPerTarget"
#       resource_label = "${aws_lb.onlyflights-alb.arn_suffix}/${aws_lb_target_group.onlyflights-ip-target-group.arn_suffix}"
#     }

#     target_value = 50

#     scale_in_cooldown = 30
#     scale_out_cooldown = 30
#   }
# }
