resource "aws_ecr_repository" "simpletimeservice" {
  name = lower(var.app_name)
  force_delete = true
  image_scanning_configuration {
    scan_on_push = true
  }

  lifecycle {
    prevent_destroy = false
  }
}

#delete
