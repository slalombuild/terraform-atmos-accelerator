# Macie component
# https://github.com/cloudposse/terraform-aws-macie
module "macie" {
  source  = "cloudposse/macie/aws"
  version = "0.1.3"

  providers = {
    aws       = aws
    aws.admin = aws.admin
  }

  context = module.this.context
}
