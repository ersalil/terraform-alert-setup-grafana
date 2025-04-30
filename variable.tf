variable "aws_region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "us-east-2" # Change default if needed
}

variable "rds_instance_identifier" {
  description = "The RDS instance ID"
  type        = string
}

variable "grafana_url" {
  description = "Grafana server URL"
  type        = string
}

variable "grafana_auth" {
  description = "Grafana API key"
  type        = string
}

variable "aws_access_key" {
  description = "AWS Access Key for Grafana to read CloudWatch"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS Secret Key for Grafana to read CloudWatch"
  type        = string
}

variable "common_alert_summary" {
  description = "Template for alert summary"
  type        = string
  default     = "🚨 Alert: {{ $labels.alertname }} is triggered! Current value: {{ $values.B.Value }} 🚨"
}

variable "levelwise_alert_summary" {
  description = "Mutiple Level - Alert Summary"
  type        = string
  default = "🚨 Alert: {{ $labels.alertname }} is triggered!\n\n{{ $value := $values.B.Value }}\n{{ if gt $value 90.0 }}\n🔴 High Severity\n(Current value: {{ printf \"%.2f\" $value }})\n{{ else if gt $value 80.0 }}\n🟠 Low Severity\n(Current value: {{ printf \"%.2f\" $value }})\n{{ else }}\n⚠️ Warning\n(Current value: {{ printf \"%.2f\" $value }})\n{{ end }} 🚨"
}

variable "alert_email_address" {
  description = "Email address to receive Grafana alerts"
  type        = string
  default     = "testsalilapp@gmail.com"
}
