variable "region" {
  type        = string
  description = "AWS Region"
}

variable "account_assignments" {
  type = map(map(map(object({
    permission_sets = list(string)
    }
  ))))
  default     = {}
  description = <<-EOT
    Enables access to permission sets for users and groups in accounts, in the following structure:

    ```yaml
    <account-name>:
      groups:
        <group-name>:
          permission_sets:
            - <permission-set-name>
      users:
        <user-name>:
          permission_sets:
            - <permission-set-name>
    ```

    EOT
}

variable "aws_teams_accessible" {
  type        = set(string)
  default     = []
  description = <<-EOT
    List of IAM roles (e.g. ["admin", "terraform"]) for which to create permission
    sets that allow the user to assume that role. Named like
    admin -> IdentityAdminTeamAccess
    EOT
}

variable "privileged" {
  type        = bool
  default     = false
  description = "True if the user running the Terraform command already has access to the Terraform backend"
}
