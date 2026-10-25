# Changelog

## [1.0.5](https://github.com/Olensys/terraform-aws-ssm-parameters/compare/v1.0.4...v1.0.5) (2026-10-25)


### Bug Fixes

* names output is null when create is false ([#5](https://github.com/Olensys/terraform-aws-ssm-parameters/issues/5)) ([403701a](https://github.com/Olensys/terraform-aws-ssm-parameters/commit/403701a8dfd1d81aa02d9ef3fd89fa067cba7199))

### Behaviour changes

`names` is now `null` instead of `[]` when `create = false`, matching every other output; guard list uses with `try(..., [])` or `coalescelist()`.

## [1.0.4](https://github.com/Olensys/terraform-aws-ssm-parameters/compare/v1.0.3...v1.0.4) (2026-10-24)


### Bug Fixes

* **examples:** unique application slug so concurrent integration runs do not collide ([#2](https://github.com/Olensys/terraform-aws-ssm-parameters/issues/2)) ([b11396e](https://github.com/Olensys/terraform-aws-ssm-parameters/commit/b11396ec23d07e90331ef6e8ee63b96164b4ff61))

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
