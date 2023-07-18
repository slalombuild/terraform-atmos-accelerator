# enabled        = true
# namespace      = "test"
# environment    = "lb-http"
# stage          = "uw2"
# label_key_case = "lower"
# project_id     = "platlive-nonprod"
# attributes     = []
# tags           = {}

# target_tags = ["test-1", "test-2"]
# backends = {
#   default = {
#     description             = null
#     port                    = 8080
#     protocol                = "HTTP"
#     port_name               = "test"
#     timeout_sec             = 10
#     enable_cdn              = false
#     custom_request_headers  = null
#     custom_response_headers = null
#     security_policy         = null
#     compression_mode        = null

#     connection_draining_timeout_sec = null
#     session_affinity                = null
#     affinity_cookie_ttl_sec         = null

#     health_check = {
#       check_interval_sec  = null
#       timeout_sec         = null
#       healthy_threshold   = null
#       unhealthy_threshold = null
#       request_path        = "/"
#       port                = 8080
#       host                = null
#       logging             = null
#     }

#     log_config = {
#       enable      = true
#       sample_rate = 1.0
#     }

#     groups = [
#       {
#         # Each node pool instance group should be added to the backend.
#         group                        = "gcs"
#         balancing_mode               = null
#         capacity_scaler              = null
#         description                  = null
#         max_connections              = null
#         max_connections_per_instance = null
#         max_connections_per_endpoint = null
#         max_rate                     = null
#         max_rate_per_instance        = null
#         max_rate_per_endpoint        = null
#         max_utilization              = null
#       },
#     ]

#     iap_config = {
#       enable               = false
#       oauth2_client_id     = null
#       oauth2_client_secret = null
#     }
#   }
# }
