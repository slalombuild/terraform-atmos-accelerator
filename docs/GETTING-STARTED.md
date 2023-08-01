
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
  * Stacks, Components, Backends
  * Workflows
* Demo the accelerator to a client, or include it in sales material
  * Powerpoint deck

## Setup your local environment

Before using the terraform accelerator, you will need to install -

* `terraform` https://developer.hashicorp.com/terraform/downloads
* `atmos` https://github.com/cloudposse/atmos
* `tflint` https://github.com/terraform-linters/tflint
* `tfsec` https://github.com/aquasecurity/tfsec
* `terraform-docs` https://github.com/terraform-docs/terraform-docs

## Setup the project

Clone this repository from https://github.com/slalombuild/terraform-accelerator
```bash
git clone --depth=1 --branch=main https://github.com/slalombuild/terraform-accelerator your-project-name
cd your-project-name
./first-time-setup.sh
```
This will clone the terraform accelerator into a folder of your choice and run the first-time-setup.sh shell script in the repository root to remove the scaffolding folders and files.

## Configure stacks of components

Next we'll configure the stacks of components to be provisioned. We'll do this on our local machine, and will setup a CI/CD workflow in a later stage.

See: [Atmos](/docs/atmos.md) and [Stacks, Components, Backends](/docs/atmos.md#stacks,%20components,%20backends)

Change to the atmos configuration folder for the cloud you want to configure
```bash
cd config/aws
```

Run `atmos describe stacks` to describe the configured stacks. The terraform accelerator already has a fully defined stack which is used for testing. While you *could* provision all of the components defined in the stack, it's highly recommended that you use the configuration as a guide, remove the unnecessary components, and choose only the components you need to get started.

```yaml
accelerator-dev:
  components:
    terraform:
      aks:
        backend: {}
        backend_type: ""
        command: terraform
        component: azure/aks     
        ...
      tfstate-backend:
        backend: {}
        backend_type: ""
        command: terraform
        component: azure/tfstate-backend
        ...
    ...
```

This stack is called `accelerator-dev` and contains the terraform components `aks` and `tfstate-backend`.

Run `atmos describe component aks --stack accelerator-dev` to describe the component in the `accelerator-dev` stack. 

```yaml
atmos_component: aks
atmos_stack: accelerator-dev
backend: {}
backend_type: ""
command: terraform
component: azure/aks
deps:
- account-globals
- dev/_defaults
- dev/westus2
env: {}
inheritance: []
metadata:
  component: azure/aks
remote_state_backend: {}
remote_state_backend_type: ""
settings: {}
sources:
  env: {}
  settings: {}
...
```

These outputs originate from the stack configurations in the `/stacks` folder.

..explain the stack config...

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


