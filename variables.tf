variable "image_tag" {
  description = "Tag of the Docker image to deploy"
  type        = string
  default     = "latest" # optional, but helps for validation
}

variable "aws-iam-role-arn" {
  description = "assume role arn"
  type = string
}

variable "aws-access-key-id" {
  type = string
}

variable "aws-secret-access-key" {
  type = string
}