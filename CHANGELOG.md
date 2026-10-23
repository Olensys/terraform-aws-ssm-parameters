# Changelog

## 1.0.1

### Fixes

- render declared provider constraints and skip .terraform in trivy scans
- declare required_version and providers in examples/minimal

## 1.0.0

- SSM Parameter Store parameters under `/<environment>/<name>/<key>`.
- SecureString by default, encrypted with `alias/aws/ssm` unless `kms_key_id` is set.
- Sensitive `parameters` input, tags applied to every parameter.
