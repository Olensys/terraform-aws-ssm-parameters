# Changelog

## 1.0.0

- SSM Parameter Store parameters under `/<environment>/<name>/<key>`.
- SecureString by default, encrypted with `alias/aws/ssm` unless `kms_key_id` is set.
- Sensitive `parameters` input, tags applied to every parameter.
