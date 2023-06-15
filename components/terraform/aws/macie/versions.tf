
terraform {
  required_version = ">= 0.15.0"

  required_providers {
    # Update these to reflect the actual requirements of your module
    aws = {
      source = "hashicorp/aws"
      # Module requires >= 3.38. Purposely allow a lower version as a (weak) test.
      version = ">= 3"
      configuration_aliases = [
        aws.admin,
        aws
      ]
    }
  }
}
