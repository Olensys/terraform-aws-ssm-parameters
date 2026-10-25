locals {
  tags = merge(var.context.extra_tags, var.tags)

  path = "${coalesce(var.path_prefix, "/${var.context.environment}")}/${var.name}"

  # Only `value` is secret. Keys, type, tier and description are structural
  # metadata, so they are unmarked to allow for_each and readable plans.
  parameter_keys = var.create ? toset(nonsensitive(keys(var.parameters))) : toset([])
}

resource "aws_ssm_parameter" "this" {
  for_each = local.parameter_keys

  name        = "${local.path}/${each.key}"
  type        = nonsensitive(var.parameters[each.key].type)
  value       = var.parameters[each.key].value
  description = nonsensitive(var.parameters[each.key].description)
  tier        = nonsensitive(var.parameters[each.key].tier)
  key_id      = nonsensitive(var.parameters[each.key].type) == "SecureString" ? var.kms_key_id : null
  tags        = local.tags
}
