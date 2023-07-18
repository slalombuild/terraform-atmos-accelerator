<!-- BEGIN-TERRAFORM-DOCS -->
## Description

Modular Global HTTP Load Balancer for GCE using forwarding rules.
* If you would like to allow for backend groups to be managed outside Terraform, such as via GKE services, see the dynamic backends submodule.
* If you would like to use load balancing with serverless backends (Cloud Run, Cloud Functions or App Engine), see the serverless_negs submodule and cloudrun example.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.72 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >=4.72.0, < 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lb-http"></a> [lb-http](#module\_lb-http) | GoogleCloudPlatform/lb-http/google | 9.1.0 |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_backends"></a> [backends](#input\_backends) | Map backend indices to list of backend maps. | <pre>map(object({<br>    port                    = optional(number)<br>    protocol                = optional(string)<br>    port_name               = optional(string)<br>    description             = optional(string)<br>    enable_cdn              = optional(bool)<br>    compression_mode        = optional(string)<br>    security_policy         = optional(string, null)<br>    edge_security_policy    = optional(string, null)<br>    custom_request_headers  = optional(list(string))<br>    custom_response_headers = optional(list(string))<br><br>    timeout_sec                     = optional(number)<br>    connection_draining_timeout_sec = optional(number)<br>    session_affinity                = optional(string)<br>    affinity_cookie_ttl_sec         = optional(number)<br><br>    health_check = object({<br>      check_interval_sec  = optional(number)<br>      timeout_sec         = optional(number)<br>      healthy_threshold   = optional(number)<br>      unhealthy_threshold = optional(number)<br>      request_path        = optional(string)<br>      port                = optional(number)<br>      host                = optional(string)<br>      logging             = optional(bool)<br>    })<br><br>    log_config = object({<br>      enable      = optional(bool)<br>      sample_rate = optional(number)<br>    })<br><br>    groups = list(object({<br>      group = string<br><br>      balancing_mode               = optional(string)<br>      capacity_scaler              = optional(number)<br>      description                  = optional(string)<br>      max_connections              = optional(number)<br>      max_connections_per_instance = optional(number)<br>      max_connections_per_endpoint = optional(number)<br>      max_rate                     = optional(number)<br>      max_rate_per_instance        = optional(number)<br>      max_rate_per_endpoint        = optional(number)<br>      max_utilization              = optional(number)<br>    }))<br>    iap_config = object({<br>      enable               = bool<br>      oauth2_client_id     = optional(string)<br>      oauth2_client_secret = optional(string)<br>    })<br>    cdn_policy = optional(object({<br>      cache_mode                   = optional(string)<br>      signed_url_cache_max_age_sec = optional(string)<br>      default_ttl                  = optional(number)<br>      max_ttl                      = optional(number)<br>      client_ttl                   = optional(number)<br>      negative_caching             = optional(bool)<br>      negative_caching_policy = optional(object({<br>        code = optional(number)<br>        ttl  = optional(number)<br>      }))<br>      serve_while_stale = optional(number)<br>      cache_key_policy = optional(object({<br>        include_host           = optional(bool)<br>        include_protocol       = optional(bool)<br>        include_query_string   = optional(bool)<br>        query_string_blacklist = optional(list(string))<br>        query_string_whitelist = optional(list(string))<br>        include_http_headers   = optional(list(string))<br>        include_named_cookies  = optional(list(string))<br>      }))<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_certificate"></a> [certificate](#input\_certificate) | Content of the SSL certificate. Required if ssl is true and ssl\_certificates is empty. | `string` | `null` | no |
| <a name="input_certificate_map"></a> [certificate\_map](#input\_certificate\_map) | Certificate Map ID in format projects/{project}/locations/global/certificateMaps/{name}. Identifies a certificate map associated with the given target proxy | `string` | `null` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_create_ipv4_address"></a> [create\_ipv4\_address](#input\_create\_ipv4\_address) | Create a new global IPv4 address or pass it as false and add an address in the next variable | `bool` | `true` | no |
| <a name="input_create_ipv6_address"></a> [create\_ipv6\_address](#input\_create\_ipv6\_address) | Allocate a new IPv6 address. Conflicts with *ipv6\_address* - if both specified, *create\_ipv6\_address* takes precedence. | `bool` | `false` | no |
| <a name="input_create_url_map"></a> [create\_url\_map](#input\_create\_url\_map) | Set to false if url\_map variable is provided. | `bool` | `true` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | yes |
| <a name="input_edge_security_policy"></a> [edge\_security\_policy](#input\_edge\_security\_policy) | The resource URL for the edge security policy to associate with the backend service | `string` | `null` | no |
| <a name="input_enable_ipv6"></a> [enable\_ipv6](#input\_enable\_ipv6) | Enable IPv6 address on the CDN load-balancer | `bool` | `false` | no |
| <a name="input_enable_ssl"></a> [enable\_ssl](#input\_enable\_ssl) | Set to true to enable SSL support, requires variable ssl\_certificates - a list of self\_link certs | `bool` | `false` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_existing_ipv4_address"></a> [existing\_ipv4\_address](#input\_existing\_ipv4\_address) | Existing IPv4 address to use (the actual IP address value) | `string` | `null` | no |
| <a name="input_existing_ipv6_address"></a> [existing\_ipv6\_address](#input\_existing\_ipv6\_address) | An existing IPv6 address to use (the actual IP address value) | `string` | `null` | no |
| <a name="input_firewall_networks"></a> [firewall\_networks](#input\_firewall\_networks) | Names of the networks to create firewall rules in | `list(string)` | `[]` | no |
| <a name="input_firewall_projects"></a> [firewall\_projects](#input\_firewall\_projects) | Names of the projects to create firewall rules in | `list(string)` | `[]` | no |
| <a name="input_http_forward"></a> [http\_forward](#input\_http\_forward) | Set to false to disable HTTP port 80 forward | `bool` | `true` | no |
| <a name="input_https_redirect"></a> [https\_redirect](#input\_https\_redirect) | Set to true to enable https redirect on the lb. | `bool` | `false` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_internal_lb_network"></a> [internal\_lb\_network](#input\_internal\_lb\_network) | Network for INTERNAL\_SELF\_MANAGED load balancing scheme | `string` | `null` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_load_balancing_scheme"></a> [load\_balancing\_scheme](#input\_load\_balancing\_scheme) | Load balancing scheme type (EXTERNAL for classic external load balancer, EXTERNAL\_MANAGED for Envoy-based load balancer, and INTERNAL\_SELF\_MANAGED for traffic director) | `string` | `"EXTERNAL"` | no |
| <a name="input_managed_ssl_certificate_domains"></a> [managed\_ssl\_certificate\_domains](#input\_managed\_ssl\_certificate\_domains) | Create Google-managed SSL certificates for specified domains. Requires ssl to be set to true and use\_ssl\_certificates set to false. | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_private_key"></a> [private\_key](#input\_private\_key) | Content of the private SSL key. Required if ssl is true and ssl\_certificates is empty. | `string` | `null` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the existing GCP project where the network will be created | `string` | n/a | yes |
| <a name="input_quic"></a> [quic](#input\_quic) | Specifies the QUIC override policy for this resource. Set true to enable HTTP/3 and Google QUIC support, false to disable both. Defaults to null which enables support for HTTP/3 only. | `bool` | `null` | no |
| <a name="input_random_certificate_suffix"></a> [random\_certificate\_suffix](#input\_random\_certificate\_suffix) | Bool to enable/disable random certificate name generation. Set and keep this to true if you need to change the SSL cert. | `bool` | `false` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_security_policy"></a> [security\_policy](#input\_security\_policy) | The resource URL for the security policy to associate with the backend service | `string` | `null` | no |
| <a name="input_ssl_certificates"></a> [ssl\_certificates](#input\_ssl\_certificates) | SSL cert self\_link list. Required if ssl is true and no private\_key and certificate is provided. | `list(string)` | `[]` | no |
| <a name="input_ssl_policy"></a> [ssl\_policy](#input\_ssl\_policy) | Selfink to SSL Policy | `string` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_target_service_accounts"></a> [target\_service\_accounts](#input\_target\_service\_accounts) | List of target service accounts for health check firewall rule. Exactly one of target\_tags or target\_service\_accounts should be specified. | `list(string)` | `[]` | no |
| <a name="input_target_tags"></a> [target\_tags](#input\_target\_tags) | List of target tags for health check firewall rule. Exactly one of target\_tags or target\_service\_accounts should be specified. | `list(string)` | `[]` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |
| <a name="input_url_map"></a> [url\_map](#input\_url\_map) | The url\_map resource to use. Default is to send all traffic to first backend. | `string` | `null` | no |
| <a name="input_use_ssl_certificates"></a> [use\_ssl\_certificates](#input\_use\_ssl\_certificates) | If true, use the certificates provided by ssl\_certificates, otherwise, create cert from private\_key and certificate | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_http-lb"></a> [http-lb](#output\_http-lb) | The otputs of created load balancer |
<!-- END-TERRAFORM-DOCS -->
