locals {
  enabled = module.this.enabled
}

data "aws_caller_identity" "current" {
  count = local.enabled ? 1 : 0
}

data "aws_partition" "current" {
  count = local.enabled ? 1 : 0
}

data "aws_region" "current" {
  count = local.enabled ? 1 : 0
}

data "aws_autoscaling_group" "default" {
  count = local.enabled ? 1 : 0

  name = var.autoscaling_group_name
}

resource "aws_autoscaling_lifecycle_hook" "default" {
  count = local.enabled ? 1 : 0

  autoscaling_group_name = var.autoscaling_group_name
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_TERMINATING"
  name                   = module.this.id
  default_result         = "CONTINUE"
  heartbeat_timeout      = 500
}

resource "aws_ssm_document" "default" {
  count = local.enabled ? 1 : 0

  content         = <<-DOC
  ---
  schemaVersion: '0.3'
  description: "Run Command on Shutdown"
  assumeRole: "{{automationAssumeRole}}"
  parameters:
    automationAssumeRole:
      type: "String"
    ASGName:
      type: "String"
    LCHName:
      type: "String"
    InstanceId:
      type: "String"
  mainSteps:
  - action: "aws:runCommand"
    name: "runCommand"
    inputs:
      Parameters:
        executionTimeout: "300"
        commands:
          - "${var.command}"
      InstanceIds:
        - "{{ InstanceId }}"
      DocumentName: "AWS-RunShellScript"
  - action: "aws:executeAwsApi"
    name: "terminateInstance"
    inputs:
      LifecycleHookName: "{{ LCHName }}"
      InstanceId: "{{ InstanceId }}"
      AutoScalingGroupName: "{{ ASGName }}"
      Service: "autoscaling"
      Api: "CompleteLifecycleAction"
      LifecycleActionResult: "CONTINUE"
  DOC
  document_type   = "Automation"
  name            = module.this.id
  document_format = "YAML"
  tags            = module.this.tags
}
