resource "grafana_folder" "RDS-folder" {
  title = "RDS"
  uid   = null
}

resource "grafana_dashboard" "rds-dash" {
   config_json = templatefile("${path.module}/dashboards/rds-metrics.json", {
   DS_CLOUDWATCH = grafana_data_source.cloudwatch.uid
  })
   folder = grafana_folder.RDS-folder.uid
   overwrite   = true
}

resource "grafana_dashboard" "rds-logs" {
   config_json = templatefile("${path.module}/dashboards/rds-logs.json", {
   DS_CLOUDWATCH = grafana_data_source.cloudwatch.uid
  })
   folder = grafana_folder.RDS-folder.uid
   overwrite   = true
}
