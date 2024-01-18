module "global_accelerator" {
  source  = "cloudposse/global-accelerator/aws"
  version = "0.6.0"

  ip_address_type     = local.ip_address_type
  flow_logs_enabled   = local.flow_logs_enabled
  flow_logs_s3_prefix = local.flow_logs_s3_prefix
  flow_logs_s3_bucket = module.s3_bucket.bucket_id

  listeners = [
    {
      client_affinity = local.client_affinity
      protocol        = local.protocol
      port_ranges = [
        {
          from_port = local.http_port
          to_port   = local.http_port
        },
        {
          from_port = local.https_port
          to_port   = local.https_port
        }
      ]
    }
  ]

  context = module.this.context
}

module "endpoint_group" {
  source  = "cloudposse/global-accelerator/aws//modules/endpoint-group"
  version = "0.6.0"

  listener_arn = module.global_accelerator.listener_ids[0]
  config = {
    endpoint_region = var.region
    endpoint_configuration = [
      {
        endpoint_lb_name = local.endpoint_lb_name
      }
    ]
  }

  context = module.this.context
}

module "s3_bucket" {
  source  = "cloudposse/s3-bucket/aws"
  version = "4.0.1"

  context = module.this.context

  force_destroy = true
}
