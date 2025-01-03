locals {
  flattened_role_assignments = flatten([
    for role, principals in var.role_assignment : [
      for principal in principals : {
        role      = role
        principal = data.azuread_group.principal[principal].object_id
      }
    ]
  ])
  smart_detector_alert_rules = {
    "dependency_latency_degradation" = {
      name          = "${module.naming.application_insights.name}-DependencyLatencyDegradation"
      detector_type = "DependencyPerformanceDegradationDetector"
      description   = "Dependency Latency Degradation notifies you of an unusual increase in response by a dependency your app is calling (e.g. REST API or database)"
      severity      = "Sev3"
      frequency     = "P1D"
    }

    "exception_anomalies" = {
      name          = "${module.naming.application_insights.name}-ExceptionAnomalies"
      detector_type = "ExceptionVolumeChangedDetector"
      description   = "Exception Anomalies notifies you of an unusual rise in the rate of exceptions thrown by your app."
      severity      = "Sev3"
      frequency     = "P1D"
    }

    "failure_anomalies" = {
      name          = "${module.naming.application_insights.name}-FailureAnomalies"
      detector_type = "FailureAnomaliesDetector"
      description   = "Failure Anomalies notifies you of an unusual rise in the rate of failed HTTP requests or dependency calls."
      severity      = "Sev3"
      frequency     = "PT1M"
    }

    "potential_memory_leak" = {
      name          = "${module.naming.application_insights.name}-PotentialMemoryLeak"
      detector_type = "MemoryLeakDetector"
      description   = "Potential Memory Leak notifies you of increased memory consumption pattern by your app which may indicate a potential memory leak."
      severity      = "Sev3"
      frequency     = "P1D"
    }

    "response_latency_degradation" = {
      name          = "${module.naming.application_insights.name}-ResponseLatencyDegradation"
      detector_type = "RequestPerformanceDegradationDetector"
      description   = "Response Latency Degradation notifies you of an unusual increase in latency in your app response to requests."
      severity      = "Sev3"
      frequency     = "P1D"
    }

    "trace_severity_degradation" = {
      name          = "${module.naming.application_insights.name}-TraceSeverityDegradation"
      detector_type = "TraceSeverityDetector"
      description   = "Trace Severity Degradation notifies you of an unusual increase in the severity of the traces generated by your app."
      severity      = "Sev3"
      frequency     = "P1D"
    }
  }
}
