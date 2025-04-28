# AWS RDS Monitoring & Alerting with Grafana - Terraform Setup

This Terraform project sets up **Grafana Dashboards** and **Alert Rules** for monitoring **AWS RDS Instances** using **CloudWatch Logs** and **Metrics**.

It automatically configures:
- Grafana Dashboards for RDS Metrics and Logs
- Alert Rules based on Logs and Metrics
- Threshold-based Notifications

---

## 📂 Project Structure

```bash
.
├── alert_setup.tf         # Setup of Grafana Alert Rules
├── dashboards/            # Folder containing Grafana dashboard JSONs
│   ├── rds-logs.json       # Grafana dashboard for RDS Logs
│   └── rds-metrics.json    # Grafana dashboard for RDS Metrics
├── dashboards.tf           # Code to import dashboards into Grafana
├── main.tf                 # Main Terraform orchestration
├── provider.tf             # Provider configurations (AWS & Grafana)
├── rds_alerts.tf           # RDS-specific alert rule definitions
├── terraform.tfstate       # Terraform state file (generated after apply)
├── terraform.tfstate.backup# Terraform backup state
├── terraform.tfvars        # Variables file (values for the variables)
└── variable.tf             # Input variable definitions
```

---

## ⚙️ Variables Explained (`variable.tf`)

| Variable Name            | Description                                | Default / Note |
| :------------------------ | :---------------------------------------- | :------------- |
| `aws_region`              | AWS Region to deploy resources into       | `us-east-2` (default) |
| `rds_instance_identifier` | Your RDS instance ID                      | **Required** |
| `grafana_url`             | Your Grafana Server URL                   | **Required** |
| `grafana_auth`            | Grafana API Key                           | **Required** |
| `aws_access_key`          | AWS Access Key for Grafana CloudWatch access | **Required** |
| `aws_secret_key`          | AWS Secret Key for Grafana CloudWatch access | **Required** |
| `common_alert_summary`    | Basic alert summary message template      | Provided |
| `levelwise_alert_summary` | Advanced alert summary with severity levels| Provided |

> **Note**: `terraform.tfvars` file is where you should put actual values for these variables.

---

## 🚨 Alerts Setup

- **Thresholds:**  
  In `rds_alerts.tf`, you will find comments like `#threshold` next to alert rules.

  ➡️ **To change alert thresholds (like CPU % or Error Count):**
  - Open `rds_alerts.tf`
  - Find the line with `#threshold`
  - Modify the threshold value (example: `params = [80.0]` → change `80.0` to `90.0`).

---

## 📊 Dashboards

- The dashboards are imported from `dashboards/rds-metrics.json` and `dashboards/rds-logs.json`.
- They show:
  - CPU, Memory, Storage, Connections, Latency ( Cloudwatch Metrics)
  - Error Logs, Admin Logs ( Cloudwatch Logs)

---

## ☁️ CloudWatch Data Sources

- The dashboards and alerts **use AWS CloudWatch** to fetch:
  - **Metrics** (like CPU utilization)
  - **Logs** (like RDS error logs)

Grafana connects to CloudWatch using the provided `aws_access_key` and `aws_secret_key`.

---

## 🛠 How to Deploy

1. Make sure you have **Terraform** installed (`terraform version`).
2. Fill in your details inside `terraform.tfvars`:
    ```hcl
    aws_region = "us-east-2"
    rds_instance_identifier = "your-rds-instance-id"
    grafana_url = "https://your-grafana-instance.com"
    grafana_auth = "eyJrIjo..."
    aws_access_key = "AKIA..."
    aws_secret_key = "your-secret-key"
    ```
3. Initialize the project:
    ```bash
    terraform init
    ```

4. Review the plan:
    ```bash
    terraform plan
    ```

5. Apply the setup:
    ```bash
    terraform apply
    ```

6. Approve the changes when prompted.

---

## 🔧 Important Notes for Modifications

- **Changing AWS Region:**  
  Update the `aws_region` variable if deploying to a different region.

- **Adding/Changing Dashboards:**  
  Replace or edit the JSON files inside `/dashboards/`.

- **Adjusting Alerts:**  
  Edit the thresholds in `rds_alerts.tf` as explained above.

- **New RDS Instance:**  
  Change `rds_instance_identifier` and re-apply.

- **Different Grafana Instance:**  
  Update `grafana_url` and `grafana_auth` with new details.

---

## 📋 Requirements

- Terraform v1.0+
- AWS Account Access
- Grafana Server with API access

---

> Happy Monitoring! 🚀 

---
