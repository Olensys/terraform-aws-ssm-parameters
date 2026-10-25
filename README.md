# terraform-aws-ssm-parameters

SSM Parameter Store parameters under an environment-scoped path, SecureString by default

## Opinions

- Path convention: every parameter is named `/<context.environment>/<name>/<key>`, so `name` is the second path segment. Set `path_prefix` (for example `/th/dev`) to replace `/<context.environment>`; `name` may nest segments with `/`.
- `SecureString` is the default parameter type; `String` and `StringList` must be requested explicitly.
- SecureString parameters use `alias/aws/ssm` unless `kms_key_id` is set.
- `context.extra_tags` merged with `tags` is applied to every parameter.
- The `parameters` input is declared `sensitive`, so values never appear in plan output.

## Usage

```hcl
module "naming" {
  source  = "git::https://github.com/Olensys/terraform-null-naming.git?ref=v1.0.1"
  context = var.context
}

module "ssm_parameters" {
  source  = "git::https://github.com/Olensys/terraform-aws-ssm-parameters.git?ref=v1.0.5"
  name    = module.naming.name
  context = var.context

  parameters = {
    db_password = { value = var.db_password }
    region      = { value = "eu-west-1", type = "String" }
  }

  tags = module.naming.tags
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0, < 7.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.0, < 7.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_ssm_parameter.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_context"></a> [context](#input\_context) | Deployment context used for naming, tagging and environment-dependent defaults. | <pre>object({<br/>    organization = string<br/>    environment  = string<br/>    application  = string<br/>    component    = optional(string)<br/>    owner        = string<br/>    cost_center  = string<br/>    extra_tags   = optional(map(string), {})<br/>  })</pre> | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Path segment(s) after the prefix. Lowercase letters, digits and hyphens; use / to nest segments (for example orchestrator/sqs). | `string` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Whether to create any resources. Set false to create nothing. | `bool` | `true` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | KMS key ID, ARN or alias used to encrypt SecureString parameters. Null uses the AWS-managed alias/aws/ssm key. | `string` | `null` | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | Parameters to create, keyed by the final path segment. type is String, StringList or SecureString (default SecureString); tier is Standard, Advanced or Intelligent-Tiering. | <pre>map(object({<br/>    value       = string<br/>    type        = optional(string, "SecureString")<br/>    description = optional(string)<br/>    tier        = optional(string, "Standard")<br/>  }))</pre> | `{}` | no |
| <a name="input_path_prefix"></a> [path\_prefix](#input\_path\_prefix) | Path prefix for every parameter, replacing the default /<context.environment>. Must start with / and not end with / (for example /th/dev). Null keeps /<context.environment>. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags merged onto every taggable resource, applied last. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_arn"></a> [arn](#output\_arn) | Map of parameter key to parameter ARN. Null when create is false. |
| <a name="output_id"></a> [id](#output\_id) | Map of parameter key to parameter name. Null when create is false. |
| <a name="output_name"></a> [name](#output\_name) | Path prefix under which all parameters live (<path\_prefix or /<environment>>/<name>). Null when create is false. |
| <a name="output_names"></a> [names](#output\_names) | List of full parameter names. Null when create is false. |
| <a name="output_tags"></a> [tags](#output\_tags) | Tags applied to every parameter, with context.extra\_tags merged in. Null when create is false. |
<!-- END_TF_DOCS -->
