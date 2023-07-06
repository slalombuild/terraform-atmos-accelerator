location            = "WestUS2"
resource_group_name = null

network = {
  address_space = "10.0.0.0/16" # 255.255.0.0
  subnets = {
    web_apps         = "10.0.0.0/24" # 255.255.255.0
    logic_apps       = "10.0.1.0/24" # 255.255.255.0
    virtual_machines = "10.0.2.0/24" # 255.255.255.0
  }
}
