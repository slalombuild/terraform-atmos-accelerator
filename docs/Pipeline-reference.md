# Pipeline reference
For the full YAML reference, see the [BitBucket pipelines configuration reference](https://support.atlassian.com/bitbucket-cloud/docs/bitbucket-pipelines-configuration-reference/).

## Image
The code for our pipeline's base image resides in [the `platform-engineering-toolkit` Slalom Build GitHub repo](https://github.com/SlalomBuild/platform-engineering-toolkit/pkgs/container/pe-toolkit-standard-alpine-amd64) and is available in the [GitHub Packages Registry](https://github.com/orgs/community/packages) (see [docs](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry)). Feel free to install new packages ad hoc within your pipeline while testing, but once you settle on an efficient set of steps, make a pull request to update the image Dockerfile rather than leaving the install steps in your pipeline.

BitBucket pipelines require that image URLs be lowercase, which may cause some small annoyance for you when copy-pasting directly from GitHub. GitHub URLs are case insensitive, so simply convert all uppercase letters to lowercase in the `image` definition.

## Steps
Each `step` in the `steps` map is defined using [YAML anchors](https://support.atlassian.com/bitbucket-cloud/docs/yaml-anchors/) to keep the `pipelines` section easy to interpret at a glance, as well as keep the entire pipeline file DRY.

**Note**: If BitBucket complains about a syntax error, it will reference the line or item in the `pipelines` section, but the actual error is most likely in the corresponding `step`.

### confirm-versions
Confirms the installed versions of [Terraform](https://www.terraform.io/) and [Atmos](https://atmos.tools/) installed by the Docker image.

### secrets-scan
Scans the repo and identifies whether any secrets have been hard-coded, using [Atlassian's `git-secrets-scan` package](https://bitbucket.org/atlassian/git-secrets-scan/src/master/).

The [BitBucket security integrations](https://bitbucket.org/product/features/pipelines/integrations?&category=security) may have additional packages of interest for later consideration.

### checkov-scan
Installs and runs [Checkov](https://www.checkov.io/), a policy-as-code tool that analyzes Terraform configuration for common misconfigurations before deployment. Checkov supports all of the cloud providers Slalom works with.

### plan
Runs `terraform plan` on your build configuration, using Atmos as the wrapper.

### apply
Runs `terraform apply` on your build configuration, using Atmos as the wrapper.

### aws-tests
Runs integration tests against the results of Terraform operations on configurations for AWS resources. For AWS resources, these tests are defined in `test/` in each Cloud Posse module we source.

### azure-tests
Runs integration tests against the results of Terraform operations on configurations for Azure DevOps resources. Currently we have implemented no tests, but when we do, they should follow a similar format to the `test/` definitions in Cloud Posse modules.

### gcp-tests
Runs integration tests against the results of Terraform operations on configurations for Google Cloud resources. Currently we have implemented no tests, but when we do, they should follow a similar format to the `test/` definitions in Cloud Posse modules.

### terraform-docs
Runs [`terraform-docs`](https://terraform-docs.io/) to update your project READMEs with a list of all providers, resources, and requirements used in the modules.

## Pipelines
The `pipelines` section defines the conditions under which specific steps will run. We use [YAML aliases](https://support.atlassian.com/bitbucket-cloud/docs/yaml-anchors/) here that refer to YAML anchors in the `definitions` section. This keeps this section's logic easy to understand at a glance.
