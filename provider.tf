provider "aws" {
  region = var.aws_region
}

provider "grafana" {
  url  = var.grafana_url
  auth = var.grafana_auth
}