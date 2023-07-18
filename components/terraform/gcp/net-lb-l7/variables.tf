variable "project_id" {
  type        = string
  description = "The ID of the existing GCP project where the network will be created"
}

variable "backends" {
  description = "Map backend indices to list of backend maps."
  type = map(object({
    port                    = optional(number)
    protocol                = optional(string)
    port_name               = optional(string)
    description             = optional(string)
    enable_cdn              = optional(bool)
    compression_mode        = optional(string)
    security_policy         = optional(string, null)
    edge_security_policy    = optional(string, null)
    custom_request_headers  = optional(list(string))
    custom_response_headers = optional(list(string))

    timeout_sec                     = optional(number)
    connection_draining_timeout_sec = optional(number)
    session_affinity                = optional(string)
    affinity_cookie_ttl_sec         = optional(number)

    health_check = object({
      check_interval_sec  = optional(number)
      timeout_sec         = optional(number)
      healthy_threshold   = optional(number)
      unhealthy_threshold = optional(number)
      request_path        = optional(string)
      port                = optional(number)
      host                = optional(string)
      logging             = optional(bool)
    })

    log_config = object({
      enable      = optional(bool)
      sample_rate = optional(number)
    })

    groups = list(object({
      group = string

      balancing_mode               = optional(string)
      capacity_scaler              = optional(number)
      description                  = optional(string)
      max_connections              = optional(number)
      max_connections_per_instance = optional(number)
      max_connections_per_endpoint = optional(number)
      max_rate                     = optional(number)
      max_rate_per_instance        = optional(number)
      max_rate_per_endpoint        = optional(number)
      max_utilization              = optional(number)
    }))
    iap_config = object({
      enable               = bool
      oauth2_client_id     = optional(string)
      oauth2_client_secret = optional(string)
    })
    cdn_policy = optional(object({
      cache_mode                   = optional(string)
      signed_url_cache_max_age_sec = optional(string)
      default_ttl                  = optional(number)
      max_ttl                      = optional(number)
      client_ttl                   = optional(number)
      negative_caching             = optional(bool)
      negative_caching_policy = optional(object({
        code = optional(number)
        ttl  = optional(number)
      }))
      serve_while_stale = optional(number)
      cache_key_policy = optional(object({
        include_host           = optional(bool)
        include_protocol       = optional(bool)
        include_query_string   = optional(bool)
        query_string_blacklist = optional(list(string))
        query_string_whitelist = optional(list(string))
        include_http_headers   = optional(list(string))
        include_named_cookies  = optional(list(string))
      }))
    }))
  }))
  default = {}
}

variable "security_policy" {
  description = "The resource URL for the security policy to associate with the backend service"
  type        = string
  default     = null
}

variable "create_ipv4_address" {
  description = "Create a new global IPv4 address or pass it as false and add an address in the next variable"
  type        = bool
  default     = true
}

variable "existing_ipv4_address" {
  description = "Existing IPv4 address to use (the actual IP address value)"
  type        = string
  default     = null
}

variable "enable_ipv6" {
  description = "Enable IPv6 address on the CDN load-balancer"
  type        = bool
  default     = false
}

variable "create_ipv6_address" {
  description = "Allocate a new IPv6 address. Conflicts with *ipv6_address* - if both specified, *create_ipv6_address* takes precedence."
  type        = bool
  default     = false
}

variable "existing_ipv6_address" {
  description = "An existing IPv6 address to use (the actual IP address value)"
  type        = string
  default     = null
}

variable "enable_ssl" {
  description = "Set to true to enable SSL support, requires variable ssl_certificates - a list of self_link certs"
  type        = bool
  default     = false
}

variable "use_ssl_certificates" {
  description = "If true, use the certificates provided by ssl_certificates, otherwise, create cert from private_key and certificate"
  type        = bool
  default     = false
}

variable "managed_ssl_certificate_domains" {
  description = "Create Google-managed SSL certificates for specified domains. Requires ssl to be set to true and use_ssl_certificates set to false."
  type        = list(string)
  default     = []
}

variable "random_certificate_suffix" {
  description = "Bool to enable/disable random certificate name generation. Set and keep this to true if you need to change the SSL cert."
  type        = bool
  default     = false
}

variable "ssl_certificates" {
  description = "SSL cert self_link list. Required if ssl is true and no private_key and certificate is provided."
  type        = list(string)
  default     = []
}

variable "certificate" {
  description = "Content of the SSL certificate. Required if ssl is true and ssl_certificates is empty."
  type        = string
  default     = null
}

variable "private_key" {
  description = "Content of the private SSL key. Required if ssl is true and ssl_certificates is empty."
  type        = string
  default     = null
}

variable "ssl_policy" {
  description = "Selfink to SSL Policy"
  type        = string
  default     = null
}

variable "certificate_map" {
  description = "Certificate Map ID in format projects/{project}/locations/global/certificateMaps/{name}. Identifies a certificate map associated with the given target proxy"
  type        = string
  default     = null
}

variable "create_url_map" {
  description = "Set to false if url_map variable is provided."
  type        = bool
  default     = true
}

variable "url_map" {
  description = "The url_map resource to use. Default is to send all traffic to first backend."
  type        = string
  default     = null
}

variable "edge_security_policy" {
  description = "The resource URL for the edge security policy to associate with the backend service"
  type        = string
  default     = null
}

variable "firewall_projects" {
  description = "Names of the projects to create firewall rules in"
  type        = list(string)
  default     = []
}

variable "firewall_networks" {
  description = "Names of the networks to create firewall rules in"
  type        = list(string)
  default     = []
}

variable "http_forward" {
  description = "Set to false to disable HTTP port 80 forward"
  type        = bool
  default     = true
}

variable "https_redirect" {
  description = "Set to true to enable https redirect on the lb."
  type        = bool
  default     = false
}

variable "target_tags" {
  description = "List of target tags for health check firewall rule. Exactly one of target_tags or target_service_accounts should be specified."
  type        = list(string)
  default     = []
}

variable "target_service_accounts" {
  description = "List of target service accounts for health check firewall rule. Exactly one of target_tags or target_service_accounts should be specified."
  type        = list(string)
  default     = []
}

variable "quic" {
  description = "Specifies the QUIC override policy for this resource. Set true to enable HTTP/3 and Google QUIC support, false to disable both. Defaults to null which enables support for HTTP/3 only."
  type        = bool
  default     = null
}

variable "load_balancing_scheme" {
  description = "Load balancing scheme type (EXTERNAL for classic external load balancer, EXTERNAL_MANAGED for Envoy-based load balancer, and INTERNAL_SELF_MANAGED for traffic director)"
  type        = string
  default     = "EXTERNAL"
}

variable "internal_lb_network" {
  description = "Network for INTERNAL_SELF_MANAGED load balancing scheme"
  type        = string
  default     = null
}

