terraform {
   required_providers {
      grafana = {
         source  = "grafana/grafana"
         version = ">= 2.9.0"
      }
      aws = {
         source  = "hashicorp/aws"
         version = "~> 5.0"
    }
   }
}

#to cross checinking the RDS instnce value is correct or not
data "aws_db_instance" "rds" {
  db_instance_identifier = var.rds_instance_identifier
}

data "aws_caller_identity" "current" {}

resource "grafana_data_source" "cloudwatch" {
  type = "cloudwatch"
  name = "cloudwatch"

  json_data_encoded = jsonencode({
    defaultRegion = var.aws_region
    authType      = "keys"
  })

  secure_json_data_encoded = jsonencode({
    accessKey = var.aws_access_key
    secretKey = var.aws_secret_key
  })
}