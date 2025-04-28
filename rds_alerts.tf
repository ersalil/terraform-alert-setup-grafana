resource "grafana_folder" "rule_folder" {
  title = "RDS Alerts"
  uid   = null
}

resource "grafana_rule_group" "rule_group_847ae2fb48b2e638" {
  name             = "Metric Alerts"
  folder_uid       = grafana_folder.rule_folder.uid
  interval_seconds = 60

  rule {
    name      = " RDS CPUUtilization"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 10800
        to   = 0
      }

      datasource_uid = grafana_data_source.cloudwatch.uid
      model = jsonencode({
        alias                  = "{{DBInstanceIdentifier}}"
        application            = { filter = "" }
        datasource             = { uid = grafana_data_source.cloudwatch.uid }
        dimensions             = { DBInstanceIdentifier = [data.aws_db_instance.rds.db_instance_identifier] }
        expression            = ""
        functions             = []
        group                 = { filter = "" }
        host                  = { filter = "" }
        id                    = ""
        instant               = false
        intervalMs           = 1000
        item                  = { filter = "" }
        label                 = "$${PROP('Dim.DBInstanceIdentifier')}"
        logGroups             = []
        matchExact            = true
        maxDataPoints        = 43200
        metricEditorMode      = 0
        metricName            = "CPUUtilization"
        metricQueryType       = 0
        mode                  = 0
        namespace             = "AWS/RDS"
        options               = { showDisabledItems = false }
        period                = ""
        queryLanguage         = "CWLI"
        queryMode             = "Metrics"
        range                 = true
        refId                 = "A"
        region                = var.aws_region
        sqlExpression         = ""
        statistic             = "Average"
      })
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model = jsonencode({
        conditions = [
          {
            evaluator = { params = [], type = "gt" }
            operator  = { type = "and" }
            query     = { params = ["C"] }
            reducer   = { params = [], type = "last" }
            type      = "query"
          }
        ]
        datasource = { type = "__expr__", uid = "__expr__" }
        expression = "A"
        intervalMs = 1000
        maxDataPoints = 43200
        reducer    = "last"
        refId      = "B"
        type       = "reduce"
      })
    }
    data {
      ref_id = "C"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model = jsonencode({
        conditions = [
          {
            evaluator = { params = [80], type = "gt" } #threshold
            operator  = { type = "and" }
            query     = { params = ["D"] }
            reducer   = { params = [], type = "last" }
            type      = "query"
          }
        ]
        datasource = { type = "__expr__", uid = "__expr__" }
        expression = "B"
        intervalMs = 1000
        maxDataPoints = 43200
        refId      = "C"
        type       = "threshold"
      })
    }

    no_data_state  = "Alerting"
    exec_err_state = "Error"
    for            = "1m"
    annotations = {
      __dashboardUid__ = "AWSRDSdbMetrics"
      __panelId__      = "16"
      summary = var.levelwise_alert_summary
    }
    labels    = {}
    is_paused = false
  }

  rule {
    name      = "RDS FreeMemory"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 10800
        to   = 0
      }

      datasource_uid = grafana_data_source.cloudwatch.uid
      model = jsonencode({
        alias               = "{{DBInstanceIdentifier}}"
        application         = { filter = "" }
        datasource          = { uid = grafana_data_source.cloudwatch.uid }
        dimensions          = { DBInstanceIdentifier = data.aws_db_instance.rds.db_instance_identifier }
        expression          = ""
        functions           = []
        group               = { filter = "" }
        host                = { filter = "" }
        id                  = ""
        instant             = false
        intervalMs          = 1000
        item                = { filter = "" }
        label               = "$${PROP('Dim.DBInstanceIdentifier')}"
        logGroups           = []
        matchExact          = true
        maxDataPoints       = 43200
        metricEditorMode    = 0
        metricName          = "FreeableMemory"
        metricQueryType     = 0
        mode                = 0
        namespace           = "AWS/RDS"
        options             = { showDisabledItems = false }
        period              = ""
        queryLanguage       = "CWLI"
        queryMode           = "Metrics"
        range               = true
        refId               = "A"
        region              = var.aws_region
        sqlExpression       = ""
        statistic           = "Average"
      })
    }

    data {
      ref_id = "E"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model = jsonencode({
        conditions = [
          {
            evaluator = { params = [], type = "gt" }
            operator  = { type = "and" }
            query     = { params = ["C"] }
            reducer   = { params = [], type = "last" }
            type      = "query"
          }
        ]
        datasource = { type = "__expr__", uid = "__expr__" }
        expression = "A"
        intervalMs = 1000
        maxDataPoints = 43200
        reducer    = "last"
        refId      = "E"
        type       = "reduce"
      })
    }

    data {
      ref_id = "C"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model = jsonencode({
        conditions = [
          {
            evaluator = { params = [240], type = "lt" } #threshold
            operator  = { type = "and" }
            query     = { params = ["B"] }
            reducer   = { params = [], type = "last" }
            type      = "query"
          }
        ]
        datasource = { type = "__expr__", uid = "__expr__" }
        expression = "B"
        intervalMs = 1000
        maxDataPoints = 43200
        refId      = "C"
        type       = "threshold"
      })
    }

    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model = jsonencode({
        conditions = [
          {
            evaluator = { params = [0, 0], type = "gt" }
            operator  = { type = "and" }
            query     = { params = [] }
            reducer   = { params = [], type = "avg" }
            type      = "query"
          }
        ]
        datasource = { name = "Expression", type = "__expr__", uid = "__expr__" }
        expression = "$E / (1024*1024*1024)"
        intervalMs = 1000
        maxDataPoints = 43200
        refId      = "B"
        type       = "math"
      })
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "1m"
    annotations = {
      __dashboardUid__ = "AWSRDSdbMetrics"
      __panelId__      = "17"
      summary = var.common_alert_summary
    }
    labels    = {}
    is_paused = false
  }

  rule {
    name      = "RDS Connections"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 10800
        to   = 0
      }

      datasource_uid = grafana_data_source.cloudwatch.uid
      model = jsonencode({
        alias               = "{{DBInstanceIdentifier}}"
        application         = { filter = "" }
        datasource          = { uid = grafana_data_source.cloudwatch.uid }
        dimensions          = { DBInstanceIdentifier = data.aws_db_instance.rds.db_instance_identifier }
        expression          = ""
        functions           = []
        group               = { filter = "" }
        host                = { filter = "" }
        id                  = ""
        instant             = false
        intervalMs          = 1000
        item                = { filter = "" }
        label               = "$${PROP('Dim.DBInstanceIdentifier')}"
        logGroups           = []
        matchExact          = true
        maxDataPoints       = 43200
        metricEditorMode    = 0
        metricName          = "DatabaseConnections"
        metricQueryType     = 0
        mode                = 0
        namespace           = "AWS/RDS"
        options             = { showDisabledItems = false }
        period              = ""
        queryLanguage       = "CWLI"
        queryMode           = "Metrics"
        range               = true
        refId               = "A"
        region              = var.aws_region
        sqlExpression       = ""
        statistic           = "Maximum"
      })
    }

    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model = jsonencode({
        conditions = [
          {
            evaluator = { params = [], type = "gt" }
            operator  = { type = "and" }
            query     = { params = ["C"] }
            reducer   = { params = [], type = "last" }
            type      = "query"
          }
        ]
        datasource = { type = "__expr__", uid = "__expr__" }
        expression = "A"
        intervalMs = 1000
        maxDataPoints = 43200
        reducer    = "last"
        refId      = "B"
        type       = "reduce"
      })
    }

    data {
      ref_id = "C"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model = jsonencode({
        conditions = [
          {
            evaluator = { params = [1500], type = "gt" } #threshold
            operator  = { type = "and" }
            query     = { params = ["D"] }
            reducer   = { params = [], type = "last" }
            type      = "query"
          }
        ]
        datasource = { type = "__expr__", uid = "__expr__" }
        expression = "B"
        intervalMs = 1000
        maxDataPoints = 43200
        refId      = "C"
        type       = "threshold"
      })
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "1m"
    annotations = {
      __dashboardUid__ = "AWSRDSdbMetrics"
      __panelId__      = "18"
      summary = var.common_alert_summary
    }
    labels    = {}
    is_paused = false
  }

  rule {
      name      = "RDS Read Latency"
      condition = "C"

      data {
         ref_id = "A"
         
         relative_time_range {
            from = 10800
            to   = 0
         }

         datasource_uid = grafana_data_source.cloudwatch.uid 
         model = jsonencode({
            alias              = "{{DBInstanceIdentifier}}"
            application        = { filter = "" }
            datasource         = { uid = grafana_data_source.cloudwatch.uid } 
            dimensions         = { DBInstanceIdentifier = [ data.aws_db_instance.rds.db_instance_identifier ] }
            expression         = ""
            functions          = []
            group              = { filter = "" }
            host               = { filter = "" }
            id                 = ""
            instant            = false
            intervalMs         = 1000
            item               = { filter = "" }
            label              = "$${PROP('Dim.DBInstanceIdentifier')}"
            logGroups          = []
            matchExact         = true
            maxDataPoints      = 43200
            metricEditorMode   = 0
            metricName         = "ReadLatency"
            metricQueryType    = 0
            mode               = 0
            namespace          = "AWS/RDS"
            options            = { showDisabledItems = false }
            period             = ""
            queryLanguage      = "CWLI"
            queryMode          = "Metrics"
            range              = true
            refId              = "A"
            region             = var.aws_region
            sqlExpression      = ""
            statistic          = "Average"
         })
      }

      data {
         ref_id = "B"

         relative_time_range {
            from = 0
            to   = 0
         }

         datasource_uid = "__expr__"
         model = jsonencode({
            conditions = [
            {
               evaluator = { params = [], type = "gt" }
               operator  = { type = "and" }
               query     = { params = ["B"] }
               reducer   = { params = [], type = "last" }
               type      = "query"
            }
            ]
            datasource = { type = "__expr__", uid = "__expr__" }
            expression = "A"
            intervalMs = 1000
            maxDataPoints = 43200
            reducer    = "last"
            refId      = "B"
            type       = "reduce"
         })
      }

      data {
         ref_id = "C"

         relative_time_range {
            from = 0
            to   = 0
         }

         datasource_uid = "__expr__"
         model = jsonencode({
            conditions = [
            {
               evaluator = { params = [10], type = "gt" } #threshold
               operator  = { type = "and" }
               query     = { params = ["C"] }
               reducer   = { params = [], type = "last" }
               type      = "query"
            }
            ]
            datasource = { type = "__expr__", uid = "__expr__" }
            expression = "B"
            intervalMs = 1000
            maxDataPoints = 43200
            refId      = "C"
            type       = "threshold"
         })
      }

      no_data_state  = "NoData"
      exec_err_state = "Error"
      for            = "1m"
      annotations = {
         __dashboardUid__ = "AWSRDSdbMetrics"
         __panelId__      = "20"
         summary = var.common_alert_summary
      }
      labels    = {}
      is_paused = false
  }

  rule {
      name      = "RDS Write Latency"
      condition = "C"

      data {
         ref_id = "A"
         
         relative_time_range {
            from = 10800
            to   = 0
         }

         datasource_uid = grafana_data_source.cloudwatch.uid 
         model = jsonencode({
            alias              = "{{DBInstanceIdentifier}}"
            application        = { filter = "" }
            datasource         = { uid = grafana_data_source.cloudwatch.uid } 
            dimensions         = { DBInstanceIdentifier = [ data.aws_db_instance.rds.db_instance_identifier ] }
            expression         = ""
            functions          = []
            group              = { filter = "" }
            host               = { filter = "" }
            id                 = ""
            instant            = false
            intervalMs         = 1000
            item               = { filter = "" }
            label              = "$${PROP('Dim.DBInstanceIdentifier')}"
            logGroups          = []
            matchExact         = true
            maxDataPoints      = 43200
            metricEditorMode   = 0
            metricName         = "WriteLatency"
            metricQueryType    = 0
            mode               = 0
            namespace          = "AWS/RDS"
            options            = { showDisabledItems = false }
            period             = ""
            queryLanguage      = "CWLI"
            queryMode          = "Metrics"
            range              = true
            refId              = "A"
            region             = var.aws_region
            sqlExpression      = ""
            statistic          = "Average"
         })
      }

      data {
         ref_id = "B"

         relative_time_range {
            from = 0
            to   = 0
         }

         datasource_uid = "__expr__"
         model = jsonencode({
            conditions = [
            {
               evaluator = { params = [], type = "gt" }
               operator  = { type = "and" }
               query     = { params = ["B"] }
               reducer   = { params = [], type = "last" }
               type      = "query"
            }
            ]
            datasource = { type = "__expr__", uid = "__expr__" }
            expression = "A"
            intervalMs = 1000
            maxDataPoints = 43200
            reducer    = "last"
            refId      = "B"
            type       = "reduce"
         })
      }

      data {
         ref_id = "C"

         relative_time_range {
            from = 0
            to   = 0
         }

         datasource_uid = "__expr__"
         model = jsonencode({
            conditions = [
            {
               evaluator = { params = [10], type = "gt" } #threshold
               operator  = { type = "and" }
               query     = { params = ["C"] }
               reducer   = { params = [], type = "last" }
               type      = "query"
            }
            ]
            datasource = { type = "__expr__", uid = "__expr__" }
            expression = "B"
            intervalMs = 1000
            maxDataPoints = 43200
            refId      = "C"
            type       = "threshold"
         })
      }

      no_data_state  = "NoData"
      exec_err_state = "Error"
      for            = "1m"
      annotations = {
         __dashboardUid__ = "AWSRDSdbMetrics"
         __panelId__      = "20"
         summary = var.common_alert_summary
      }
      labels    = {}
      is_paused = false
  }

  rule {
    name      = "RDS Disk Queue Depth"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 10800
        to   = 0
      }

      datasource_uid = grafana_data_source.cloudwatch.uid
      model = jsonencode({
        alias               = "{{DBInstanceIdentifier}}"
        application         = { filter = "" }
        datasource          = { uid = grafana_data_source.cloudwatch.uid }
        dimensions          = { DBInstanceIdentifier = data.aws_db_instance.rds.db_instance_identifier }
        expression          = ""
        functions           = []
        group               = { filter = "" }
        host                = { filter = "" }
        id                  = ""
        instant             = false
        intervalMs          = 1000
        item                = { filter = "" }
        label               = "$${PROP('Dim.DBInstanceIdentifier')}"
        logGroups           = []
        matchExact          = true
        maxDataPoints       = 43200
        metricEditorMode    = 0
        metricName          = "DiskQueueDepth"
        metricQueryType     = 0
        mode                = 0
        namespace           = "AWS/RDS"
        options             = { showDisabledItems = false }
        period              = ""
        queryLanguage       = "CWLI"
        queryMode           = "Metrics"
        range               = true
        refId               = "A"
        region              = var.aws_region
        sqlExpression       = ""
        statistic           = "Maximum"
      })
    }

    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model = jsonencode({
        conditions = [
          {
            evaluator = { params = [], type = "gt" }
            operator  = { type = "and" }
            query     = { params = ["C"] }
            reducer   = { params = [], type = "last" }
            type      = "query"
          }
        ]
        datasource = { type = "__expr__", uid = "__expr__" }
        expression = "A"
        intervalMs = 1000
        maxDataPoints = 43200
        reducer    = "last"
        refId      = "B"
        type       = "reduce"
      })
    }

    data {
      ref_id = "C"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model = jsonencode({
        conditions = [
          {
            evaluator = { params = [10], type = "gt" } #threshold
            operator  = { type = "and" }
            query     = { params = ["D"] }
            reducer   = { params = [], type = "last" }
            type      = "query"
          }
        ]
        datasource = { type = "__expr__", uid = "__expr__" }
        expression = "B"
        intervalMs = 1000
        maxDataPoints = 43200
        refId      = "C"
        type       = "threshold"
      })
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "1m"
    annotations = {
      __dashboardUid__ = "AWSRDSdbMetrics"
      __panelId__      = "18"
      summary = var.common_alert_summary
    }
    labels    = {}
    is_paused = false
  }

  rule {
      name      = "RDS WriteThroughput"
      condition = "C"

      data {
         ref_id = "A"
         
         relative_time_range {
            from = 10800
            to   = 0
         }

         datasource_uid = grafana_data_source.cloudwatch.uid 
         model = jsonencode({
            alias              = "{{DBInstanceIdentifier}}"
            application        = { filter = "" }
            datasource         = { uid = grafana_data_source.cloudwatch.uid } 
            dimensions         = { DBInstanceIdentifier = [ data.aws_db_instance.rds.db_instance_identifier ] }
            expression         = ""
            functions          = []
            group              = { filter = "" }
            host               = { filter = "" }
            id                 = ""
            instant            = false
            intervalMs         = 1000
            item               = { filter = "" }
            label              = "$${PROP('Dim.DBInstanceIdentifier')}"
            logGroups          = []
            matchExact         = true
            maxDataPoints      = 43200
            metricEditorMode   = 0
            metricName         = "WriteThroughput"
            metricQueryType    = 0
            mode               = 0
            namespace          = "AWS/RDS"
            options            = { showDisabledItems = false }
            period             = ""
            queryLanguage      = "CWLI"
            queryMode          = "Metrics"
            range              = true
            refId              = "A"
            region             = var.aws_region
            sqlExpression      = ""
            statistic          = "Average"
         })
      }

      data {
         ref_id = "B"

         relative_time_range {
            from = 0
            to   = 0
         }

         datasource_uid = "__expr__"
         model = jsonencode({
            conditions = [
            {
               evaluator = { params = [], type = "gt" }
               operator  = { type = "and" }
               query     = { params = ["B"] }
               reducer   = { params = [], type = "last" }
               type      = "query"
            }
            ]
            datasource = { type = "__expr__", uid = "__expr__" }
            expression = "A"
            intervalMs = 1000
            maxDataPoints = 43200
            reducer    = "last"
            refId      = "B"
            type       = "reduce"
         })
      }

      data {
         ref_id = "C"

         relative_time_range {
            from = 0
            to   = 0
         }

         datasource_uid = "__expr__"
         model = jsonencode({
            conditions = [
            {
               evaluator = { params = [10], type = "gt" } #threshold
               operator  = { type = "and" }
               query     = { params = ["C"] }
               reducer   = { params = [], type = "last" }
               type      = "query"
            }
            ]
            datasource = { type = "__expr__", uid = "__expr__" }
            expression = "B"
            intervalMs = 1000
            maxDataPoints = 43200
            refId      = "C"
            type       = "threshold"
         })
      }

      no_data_state  = "NoData"
      exec_err_state = "Error"
      for            = "1m"
      annotations = {
         __dashboardUid__ = "AWSRDSdbMetrics"
         __panelId__      = "20"
         summary = var.common_alert_summary
      }
      labels    = {}
      is_paused = false
  }

  rule {
      name      = "RDS ReadThroughput"
      condition = "C"

      data {
         ref_id = "A"
         
         relative_time_range {
            from = 10800
            to   = 0
         }

         datasource_uid = grafana_data_source.cloudwatch.uid 
         model = jsonencode({
            alias              = "{{DBInstanceIdentifier}}"
            application        = { filter = "" }
            datasource         = { uid = grafana_data_source.cloudwatch.uid } 
            dimensions         = { DBInstanceIdentifier = [ data.aws_db_instance.rds.db_instance_identifier ] }
            expression         = ""
            functions          = []
            group              = { filter = "" }
            host               = { filter = "" }
            id                 = ""
            instant            = false
            intervalMs         = 1000
            item               = { filter = "" }
            label              = "$${PROP('Dim.DBInstanceIdentifier')}"
            logGroups          = []
            matchExact         = true
            maxDataPoints      = 43200
            metricEditorMode   = 0
            metricName         = "ReadThroughput"
            metricQueryType    = 0
            mode               = 0
            namespace          = "AWS/RDS"
            options            = { showDisabledItems = false }
            period             = ""
            queryLanguage      = "CWLI"
            queryMode          = "Metrics"
            range              = true
            refId              = "A"
            region             = var.aws_region
            sqlExpression      = ""
            statistic          = "Average"
         })
      }

      data {
         ref_id = "B"

         relative_time_range {
            from = 0
            to   = 0
         }

         datasource_uid = "__expr__"
         model = jsonencode({
            conditions = [
            {
               evaluator = { params = [], type = "gt" }
               operator  = { type = "and" }
               query     = { params = ["B"] }
               reducer   = { params = [], type = "last" }
               type      = "query"
            }
            ]
            datasource = { type = "__expr__", uid = "__expr__" }
            expression = "A"
            intervalMs = 1000
            maxDataPoints = 43200
            reducer    = "last"
            refId      = "B"
            type       = "reduce"
         })
      }

      data {
         ref_id = "C"

         relative_time_range {
            from = 0
            to   = 0
         }

         datasource_uid = "__expr__"
         model = jsonencode({
            conditions = [
            {
               evaluator = { params = [10], type = "gt" } #threshold
               operator  = { type = "and" }
               query     = { params = ["C"] }
               reducer   = { params = [], type = "last" }
               type      = "query"
            }
            ]
            datasource = { type = "__expr__", uid = "__expr__" }
            expression = "B"
            intervalMs = 1000
            maxDataPoints = 43200
            refId      = "C"
            type       = "threshold"
         })
      }

      no_data_state  = "NoData"
      exec_err_state = "Error"
      for            = "1m"
      annotations = {
         __dashboardUid__ = "AWSRDSdbMetrics"
         __panelId__      = "20"
         summary = var.common_alert_summary
      }
      labels    = {}
      is_paused = false
  }

  rule {
    name      = "RDS Log Error"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.cloudwatch.uid
      model = jsonencode({
         datasource = {
            type = "cloudwatch"
            uid  = grafana_data_source.cloudwatch.uid
         }
         dimensions  = {}
         expression  = <<-EOT
         fields @timestamp, @message
         | filter @message like /ERROR/
         | parse @message /(?<error_type>ERROR)/
         | stats count() as error_count by error_type, bin(@timestamp, 10m)
         EOT
         id               = ""
         instant          = true
         intervalMs       = 1000
         label            = ""
         logGroups        = [
            {
               accountId = data.aws_caller_identity.current.account_id
               arn       = "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:RDSOSMetrics:*"
               name      = "RDSOSMetrics"
            }
         ]
         matchExact       = true
         maxDataPoints    = 43200
         metricEditorMode = 0
         metricName       = ""
         metricQueryType  = 0
         namespace        = ""
         period           = ""
         queryLanguage    = "CWLI"
         queryMode        = "Logs"
         refId            = "A"
         region           = var.aws_region
         sqlExpression    = ""
         statistic        = "Average"
         statsGroups      = ["error_type", "bin(@timestamp", "10m)"]
         })

    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model = jsonencode({
      conditions = [
         {
            evaluator = {
            params = [0, 0]
            type   = "gt"
            }
            operator = {
            type = "and"
            }
            query = {
            params = []
            }
            reducer = {
            params = []
            type   = "avg"
            }
            type = "query"
         }
      ]
      datasource = {
         name = "Expression"
         type = "__expr__"
         uid  = "__expr__"
      }
      expression     = "A"
      intervalMs     = 1000
      maxDataPoints  = 43200
      reducer        = "max"
      refId          = "B"
      settings       = {
         mode = ""
      }
      type           = "reduce"
      })

    }
    data {
      ref_id = "C"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model = jsonencode({
      conditions = [
         {
            evaluator = {
            params = [0, 0] #threshold
            type   = "gt"
            }
            operator = {
            type = "and"
            }
            query = {
            params = []
            }
            reducer = {
            params = []
            type   = "avg"
            }
            type = "query"
         }
      ]
      datasource = {
         name = "Expression"
         type = "__expr__"
         uid  = "__expr__"
      }
      expression     = "B"
      intervalMs     = 1000
      maxDataPoints  = 43200
      refId          = "C"
      type           = "threshold"
      })

    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    annotations = {
      "More Details"   = "Error Type: {{ $labels.error_type }}\nTotal Errors in Last 10min: {{ $values.B.Value }}"
      __dashboardUid__ = "AWSRDSdbLOGS"
      __panelId__      = "2"
      summary          = "🚨 RDS Alert got Triggered from Logs 🚨"
    }
    labels    = {}
    is_paused = false

  }

}