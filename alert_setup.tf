resource "grafana_contact_point" "email" {
  name = "Alert Email"
  email {
    addresses = ["salil.hexa@gmail.com"]
  }
}

resource "grafana_notification_policy" "notification-policy" {
  contact_point = grafana_contact_point.email.name
  group_by = ["..."]
}