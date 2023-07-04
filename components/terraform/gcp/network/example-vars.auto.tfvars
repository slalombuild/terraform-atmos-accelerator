# enabled        = true
# namespace      = "test"
# environment    = "network"
# stage          = "uw2"
# label_key_case = "lower"
# project_id     = "platlive-nonprod"
# region         = "us-west2"

# routing_mode          = "GLOBAL"
# shared_vpc_host       = false
# service_project_names = []

# subnets = [
#   {
#     subnet_name               = "subnet-1"
#     subnet_ip                 = "10.1.0.0/16"
#     subnet_region             = "us-west2"
#     subnet_private_access     = true
#     subnet_flow_logs          = true
#     subnet_flow_logs_interval = "INTERVAL_5_SEC"
#     subnet_flow_logs_sampling = 0.5
#     subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
#   },
#   {
#     subnet_name           = "subnet-2"
#     subnet_ip             = "10.2.0.0/16"
#     subnet_region         = "us-west2"
#     subnet_private_access = false
#     subnet_flow_logs      = false
#   }
# ]

# secondary_ranges = {
#   "subnet-1" = [
#     {
#       ip_cidr_range = "172.16.1.0/24"
#       range_name    = "pods-1"
#     },
#     {
#       ip_cidr_range = "192.168.1.0/24"
#       range_name    = "services-1"
#     }
#   ]

#   "subnet-2" = [{
#     ip_cidr_range = "172.16.2.0/24"
#     range_name    = "pods-2"
#     },
#     {
#       ip_cidr_range = "192.168.2.0/24"
#       range_name    = "services-2"
#     }
#   ]
# }

# routes = [
#   {
#     name              = "egress-internet"
#     destination_range = "0.0.0.0/0"
#     tags              = "egress-inet,internet"
#     next_hop_internet = "true"
#   }
# ]

# firewall_rules = [
#   {
#     name      = "test"
#     direction = "INGRESS"
#     ranges    = ["10.2.0.0/16"]
#     allow = [{
#       protocol = "TCP"
#     }]
#   }
# ]

# cloud_nat = {
#   subnetworks = [
#     {
#       name                    = "subnet-1"
#       source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
#     },
#     {
#       name                    = "subnet-2"
#       source_ip_ranges_to_nat = ["10.2.0.0/16", "172.16.2.0/24", "192.168.2.0/24"]
#     }
#   ]
# }

# peers = []

# private_connections = [
#   {
#     name          = "test-data"
#     prefix_start  = "10.3.0.0"
#     prefix_length = 16
#   }
# ]


