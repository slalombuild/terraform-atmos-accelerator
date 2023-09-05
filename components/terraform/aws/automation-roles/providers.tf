variable "region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-2"
}

provider "aws" {
  alias   = "auto"
  region  = var.region
  profile = "accelerator-auto"
}

provider "aws" {
  alias   = "dev"
  region  = var.region
  profile = "accelerator-dev"
}

provider "aws" {
  alias   = "staging"
  region  = var.region
  profile = "accelerator-staging"
}

provider "aws" {
  alias   = "prod"
  region  = var.region
  profile = "accelerator-prod"
}
