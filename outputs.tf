output "id" {
  description = "Map of parameter key to parameter name. Null when create is false."
  value       = var.create ? { for k, p in aws_ssm_parameter.this : k => p.id } : null
}

output "name" {
  description = "Path prefix under which all parameters live (/<environment>/<name>). Null when create is false."
  value       = var.create ? "/${var.context.environment}/${var.name}" : null
}

output "arn" {
  description = "Map of parameter key to parameter ARN. Null when create is false."
  value       = var.create ? { for k, p in aws_ssm_parameter.this : k => p.arn } : null
}

output "names" {
  description = "List of full parameter names. Empty when create is false."
  value       = [for k, p in aws_ssm_parameter.this : p.name]
}

output "tags" {
  description = "Tags applied to every parameter, with context.extra_tags merged in. Null when create is false."
  value       = var.create ? local.tags : null
}
