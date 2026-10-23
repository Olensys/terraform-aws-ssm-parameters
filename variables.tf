variable "name" {
  description = "Resource name. Lowercase letters, digits and hyphens."
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9-]{1,63}$", var.name))
    error_message = "name must match ^[a-z0-9-]{1,63}$."
  }
}

variable "context" {
  description = "Deployment context used for naming, tagging and environment-dependent defaults."
  type = object({
    organization = string
    environment  = string
    application  = string
    component    = optional(string)
    owner        = string
    cost_center  = string
    extra_tags   = optional(map(string), {})
  })
  validation {
    condition     = contains(["dev", "staging", "prod", "test", "shared"], var.context.environment)
    error_message = "context.environment must be one of dev, staging, prod, test, shared."
  }
}

variable "create" {
  description = "Whether to create any resources. Set false to create nothing."
  type        = bool
  default     = true
}

variable "parameters" {
  description = "Parameters to create, keyed by the final path segment. type is String, StringList or SecureString (default SecureString); tier is Standard, Advanced or Intelligent-Tiering."
  type = map(object({
    value       = string
    type        = optional(string, "SecureString")
    description = optional(string)
    tier        = optional(string, "Standard")
  }))
  sensitive = true
  default   = {}

  validation {
    condition     = alltrue([for p in values(var.parameters) : contains(["String", "StringList", "SecureString"], p.type)])
    error_message = "Each parameter type must be one of String, StringList, SecureString."
  }

  validation {
    condition     = alltrue([for p in values(var.parameters) : contains(["Standard", "Advanced", "Intelligent-Tiering"], p.tier)])
    error_message = "Each parameter tier must be one of Standard, Advanced, Intelligent-Tiering."
  }
}

variable "kms_key_id" {
  description = "KMS key ID, ARN or alias used to encrypt SecureString parameters. Null uses the AWS-managed alias/aws/ssm key."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags merged onto every taggable resource, applied last."
  type        = map(string)
  default     = {}
}
