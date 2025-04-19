#New Infra Provisioning
module "ecs_fargate" {
  source              = "./ecs-fargate"
  app_name            = "SimpTimeServ-new"
  region              = "us-east-1"
  domain_name         = "simpletimeservice.cloudvj.in" # Change this according to your domain
  hosted_zone_id      = "Z03659932DLDYYQJTHLW" # change it to your hosted zone ID
  container_port      = 80
  image_tag = var.image_tag
}
