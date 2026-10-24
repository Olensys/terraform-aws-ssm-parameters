# Changelog

## [1.0.3](https://github.com/Olensys/terraform-aws-ssm-parameters/compare/v1.0.2...v1.0.3) (2026-10-24)


### Bug Fixes

* run integration on change and weekly instead of nightly ([415a60c](https://github.com/Olensys/terraform-aws-ssm-parameters/commit/415a60cf0dcf978f9e94550bd0f948c3cb3fb231))

## 1.0.2

### Tests

- Added `test_tags_contract`: `tags` wins over `context.extra_tags`, and extra tags are merged.

### Docs

- README Usage shows the naming module.

## 1.0.1

### Fixes

- render declared provider constraints and skip .terraform in trivy scans
- declare required_version and providers in examples/minimal

## 1.0.0

- SSM Parameter Store parameters under `/<environment>/<name>/<key>`.
- SecureString by default, encrypted with `alias/aws/ssm` unless `kms_key_id` is set.
- Sensitive `parameters` input, tags applied to every parameter.
