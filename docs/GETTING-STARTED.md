
# Getting Started

## Overview

The terraform accelerator is a new project template for provisioning infrastructure as code in AWS, Azure or GCP. Typically you would use this accelerator after using a cloud-specific accelerator to setup an account hierarchy (such as the AWS Landing Zone Accelerator or the Azure Cloud Adoption Framework). Every cloud operator provides their own bespoke setup framework, and we believe it's best to use their tools.

There are 4 main use cases for this accelerator:

* Use the accelerator to provision and manage infrastructure in one or more clouds
  * Setup your local environment
  * Setup the project
  * Configure stacks of components
  * Configure CI/CD workflows
* Use part of the accelerator (for example, a component such as EKS) and use it on a different project
  * Anatomy of a component
  * `atmos vendor` vs copy and paste
* Learn about this accelerator, and the patterns and standards used
  * Atmos
  * Workflows
* Demo the accelerator to a client, or include it in sales material
  * Powerpoint deck

### Before using this accelerator

We recommend that you configure these AWS accounts/Azure subscriptions/GCP projects -

| AWS Account / Azure Subscription / GCP Project | Purpose |
| - | - |
| Automation | This is where your CI/CD pipelines will run |
| Development | This is where you'll deploy development to |
| Production | This is where you'll deploy production to |

In reality, you'll likely have several more environments (such as testing, staging, etc), but once you've configured these essential environments, adding more environments is straightforward.

## Setup your local environment

Before using the terraform accelerator, you will need to install -

* `terraform` https://developer.hashicorp.com/terraform/downloads
* `atmos` https://github.com/cloudposse/atmos
* `tflint` https://github.com/terraform-linters/tflint
* `tfsec` https://github.com/aquasecurity/tfsec
* `terraform-docs` https://github.com/terraform-docs/terraform-docs
* `yq` https://github.com/mikefarah/yq

## Clone the accelerator repo

Clone this repository from https://github.com/slalombuild/terraform-accelerator
```bash
git clone --depth=1 --branch=main https://github.com/slalombuild/terraform-accelerator your-project-name
cd your-project-name
./first-time-setup.sh
```
This will clone the terraform accelerator into a folder of your choice and run the first-time-setup.sh shell script in the repository root to remove the scaffolding folders and files.

## Configure stacks of components

Next we'll configure the stacks of components to be provisioned. We'll do this on our local machine, and we'll setup a CI/CD workflow in a later stage.

> IMPORTANT: Need an introduction to Atmos? See [Atmos](/docs/atmos.md) and [Atmos CLI command cheat sheet](https://atmos.tools/cli/cheatsheet)

Change to the atmos configuration folder for the cloud you want to configure (we'll use `aws` as an example):
```bash
cd examples/config/aws
```

> NOTE: `/config` and `/stacks` contains the configuration and stacks used by the terraform accelerator development team. `/stacks` will be cleared by the `first-time-setup.sh` script, so that you can configure your own stacks.

Run `atmos describe stacks` to describe the configured stacks in `/examples/stacks/aws`. The terraform accelerator has several example stacks defined to help you learn the structure.


```yaml
automation-ue2:
  components:
    terraform:
      tfstate-backend:
        backend: {}
        backend_type: ""
        command: terraform
        component: azure/tfstate-backend
        ...
      vpc:
        backend:
        ...
    ...
```

> NOTE: You can obtain a more useful list of the stacks defined by using `yq`. For example: `atmos describe stacks | yq '. | keys'`
> ```yaml
> - automation-ue2
> - development-ue2
> - production-ue2
> ```

You'll see several example stacks -
* an **automation** stack, containing these components:
  * a VPC
  * S3 bucket for terraform state
* a **development** stack, containing these components:
  * a VPC
  * S3 bucket for terraform state
* a **production** stack, containing these components:
  * a VPC
  * S3 bucket for terraform state


Run `atmos describe component vpc --stack development-ue2` to describe the components in the `development-ue2` stack. 

```yaml
atmos_component: vpc
atmos_stack: development-ue2
backend:
  acl: bucket-owner-full-control
  bucket: accelerator-auto-ue2-tfstate
  dynamodb_table: accelerator-auto-ue2-tfstate-lock
  encrypt: true
  key: terraform.tfstate
  region: us-east-2
  workspace_key_prefix: vpc
backend_type: s3
command: terraform
component: vpc
deps:
- development/us-east-2
- global/defaults
env: {}
...
```

> NOTE: You can obtain a more concise list of the stacks defined by using `yq`. For example: `atmos describe stacks | yq '. | keys'`
> ```yaml
> - automation-ue2
> - development-ue2
> - production-ue2
> ```


 ++ Update stack/component guidances goes here ++

Purpose of these accounts:
 ++ automation
 ++ catalog
 ++ dev
 ++ prod
 ++ staging
 ++ workflows

What goes where
`_defaults.yaml`
`globals.yaml`
`account-globals.yaml`


---


## Before you start to build your infrastructure


## Project Setup

Instructions go here.

## Setup for AWS

Instructions go here.

## Setup for Azure

Instructions go here.

## Setup for GCP

Instructions go here.

## Setup for GitHub

## Setup for other CI/CD tools


