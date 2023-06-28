# enabled        = true
# namespace      = "test"
# environment    = "network"
# stage          = "uw2"
# label_key_case = "lower"
# project_id     = "platlive-nonprod"
# region         = "us-west2"
# routing_mode   = "GLOBAL"

# subnets = [
#   {
#     subnet_name           = "subnet-1",
#     cidr                  = "10.1.0.0/16",
#     private_google_access = true,
#     secondary_cidrs = [
#       {
#         name  = "pods-1"
#         cidr = "172.16.1.0/24"
#       },
#       {
#         name  = "services-1"
#         cidr = "192.168.1.0/24"
#       }
#     ],
#     flow_logs = {
#       aggregation_interval = "INTERVAL_5_SEC"
#       flow_sampling        = "0.5"
#       metadata             = "INCLUDE_ALL_METADATA"
#     }
#   },
#   {
#     subnet_name = "subnet-2",
#     cidr        = "10.2.0.0/16",
#     secondary_cidrs = [
#       {
#         name  = "pods-2"
#         cidr = "172.16.2.0/24"
#       },
#       {
#         name  = "services-2"
#         cidr = "192.168.2.0/24"
#     }]
#   }
# ]

# routes = [
#   {
#     name              = "egress-internet"
#     destination_range = "0.0.0.0/0"
#     tags              = "egress-inet,internet"
#     next_hop_internet = "true"
#   }
# ]

# ## must need to pass name of the subnet like {namespace}-{environment-{stage}-{subnet_name}
# cloud_nat = {
#   subnetworks = [
#     {
#       name                    = "test-network-uw2-subnet-1"
#       source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
#     },
#     {
#       name                    = "test-network-uw2-subnet-2"
#       source_ip_ranges_to_nat = ["10.2.0.0/16", "172.16.2.0/24", "192.168.2.0/24"]
#     }
#   ]
# }

# shared_vpc_host       = false
# service_project_names = []
# peers                 = []

# firewall_rules = [
#   {
#     name      = "test",
#     direction = "INGRESS",
#     ranges    = ["10.2.0.0/16"]
#     allow = [{
#       protocol = "TCP"
#     }]
#   }
# ]

# private_connections = [
#   {
#     name          = "test-data"
#     prefix_start  = "10.3.0.0"
#     prefix_length = 16
#   }
# ]

    