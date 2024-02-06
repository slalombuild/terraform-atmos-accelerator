# Example rules for WAF 
module "waf" {
  source  = "cloudposse/waf/aws"
  version = "1.4.0"

  # A rule statement used to run the rules that are defined in a managed rule group.

  managed_rule_group_statement_rules = [
    {
      name            = "rule-20-AWSManagedRulesCommonRuleSet"
      override_action = "count"
      priority        = 20

      statement = {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"

        excluded_rule = [
          "SizeRestrictions_QUERYSTRING",
          "NoUserAgent_HEADER"
        ]
      }

      visibility_config = {
        cloudwatch_metrics_enabled = false
        sampled_requests_enabled   = false
        metric_name                = "rule-20-metric"
      }
    },
    {
      name            = "rule-21-AWSManagedRulesAmazonIpReputationList"
      override_action = "count"
      priority        = 21

      statement = {
        name        = "AWSManagedRulesAmazonIpReputationList"
        vendor_name = "AWS"

        excluded_rule = [
          "SizeRestrictions_QUERYSTRING",
          "NoUserAgent_HEADER"
        ]
      }
      visibility_config = {
        cloudwatch_metrics_enabled = false
        sampled_requests_enabled   = false
        metric_name                = "rule-21-metric"
      }
    },
    {
      name            = "rule-23-AWSManagedRulesLinuxRuleSet"
      override_action = "count"
      priority        = 23

      statement = {
        name        = "AWSManagedRulesLinuxRuleSet"
        vendor_name = "AWS"

        excluded_rule = [
          "SizeRestrictions_QUERYSTRING",
          "NoUserAgent_HEADER"
        ]
      }
      visibility_config = {
        cloudwatch_metrics_enabled = false
        sampled_requests_enabled   = false
        metric_name                = "rule-23-metric"
      }
    },
    {
      name            = "rule-24-AWSManagedRulesUnixRuleSet"
      override_action = "count"
      priority        = 24

      statement = {
        name        = "AWSManagedRulesUnixRuleSet"
        vendor_name = "AWS"

        excluded_rule = [
          "SizeRestrictions_QUERYSTRING",
          "NoUserAgent_HEADER"
        ]
      }
      visibility_config = {
        cloudwatch_metrics_enabled = false
        sampled_requests_enabled   = false
        metric_name                = "rule-24-metric"
      }
    },
    {
      name            = "rule-25-AWSManagedRulesWordPressRuleSet"
      override_action = "count"
      priority        = 25

      statement = {
        name        = "AWSManagedRulesWordPressRuleSet"
        vendor_name = "AWS"

        excluded_rule = [
          "SizeRestrictions_QUERYSTRING",
          "NoUserAgent_HEADER"
        ]
      }
      visibility_config = {
        cloudwatch_metrics_enabled = false
        sampled_requests_enabled   = false
        metric_name                = "rule-25-metric"
      }
    }

  ]

  # A rule statement that defines a string match search for AWS WAF to apply to web requests.

  byte_match_statement_rules = [
    {
      name     = "rule-30"
      action   = "allow"
      priority = 30

      statement = {
        positional_constraint = "EXACTLY"
        search_string         = "/cp-key"

        text_transformation = [
          {
            priority = 30
            type     = "COMPRESS_WHITE_SPACE"
          }
        ]

        field_to_match = {
          uri_path = {}
        }
      }

      visibility_config = {
        cloudwatch_metrics_enabled = false
        sampled_requests_enabled   = false
        metric_name                = "rule-30-metric"
      }
    }
  ]

  # A rate-based rule tracks the rate of requests for each originating IP address, and triggers the rule action when the rate exceeds a limit that you specify on the number of requests in any 5-minute time span.

  rate_based_statement_rules = [
    {
      name     = "rule-40"
      action   = "block"
      priority = 40

      statement = {
        limit              = 100
        aggregate_key_type = "IP"
      }

      visibility_config = {
        cloudwatch_metrics_enabled = false
        sampled_requests_enabled   = false
        metric_name                = "rule-40-metric"
      }
    }
  ]

  # A rule statement that uses a comparison operator to compare a number of bytes against the size of a request component.

  size_constraint_statement_rules = [
    {
      name     = "rule-50"
      action   = "block"
      priority = 50

      statement = {
        comparison_operator = "GT"
        size                = 15

        field_to_match = {
          all_query_arguments = {}
        }

        text_transformation = [
          {
            type     = "COMPRESS_WHITE_SPACE"
            priority = 1
          }
        ]

      }

      visibility_config = {
        cloudwatch_metrics_enabled = false
        sampled_requests_enabled   = false
        metric_name                = "rule-50-metric"
      }
    }
  ]

  # A rule statement that defines a cross-site scripting (XSS) match search for AWS WAF to apply to web requests.

  xss_match_statement_rules = [
    {
      name     = "rule-60"
      action   = "block"
      priority = 60

      statement = {
        field_to_match = {
          uri_path = {}
        }

        text_transformation = [
          {
            type     = "URL_DECODE"
            priority = 1
          },
          {
            type     = "HTML_ENTITY_DECODE"
            priority = 2
          }
        ]

      }

      visibility_config = {
        cloudwatch_metrics_enabled = false
        sampled_requests_enabled   = false
        metric_name                = "rule-60-metric"
      }
    }
  ]

  # An SQL injection match condition identifies the part of web requests, such as the URI or the query string, that you want AWS WAF to inspect.

  sqli_match_statement_rules = [
    {
      name     = "rule-70"
      action   = "block"
      priority = 70

      statement = {

        field_to_match = {
          query_string = {}
        }

        text_transformation = [
          {
            type     = "URL_DECODE"
            priority = 1
          },
          {
            type     = "HTML_ENTITY_DECODE"
            priority = 2
          }
        ]

      }

      visibility_config = {
        cloudwatch_metrics_enabled = false
        sampled_requests_enabled   = false
        metric_name                = "rule-70-metric"
      }
    }
  ]

  context = module.this.context
}
