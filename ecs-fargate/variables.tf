variable "app_name" {
  description = "Application Name"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
}

# variable "vpc_id" {
#   description = "VPC ID"
#   type        = string
# }

# variable "subnet_ids" {
#   description = "List of subnet IDs for Fargate and ALB"
#   type        = list(string)
# }


variable "container_port" {
  description = "Port on which the container listens"
  type        = number
  default     = 80
}

variable "domain_name" {
  description = "Full domain name for Route53 (e.g., simpletimeservice.cloudvj.xyz)"
  type        = string
}

variable "hosted_zone_id" {
  description = "Hosted Zone ID in Route 53"
  type        = string
}

variable "image_tag" {
  description = "The image tag (commit hash) to deploy"
  type        = string
  default     = "latest"
}
