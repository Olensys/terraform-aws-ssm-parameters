mock_provider "aws" {}

variables {
  context = {
    organization = "olensys"
    environment  = "test"
    application  = "example"
    owner        = "platform"
    cost_center  = "eng"
    extra_tags   = { Team = "core" }
  }
  name = "example"
  parameters = {
    db_password = { value = "s3cret" }
    region      = { value = "eu-west-1", type = "String", description = "Region", tier = "Advanced" }
  }
}

run "test_path_convention" {
  command = plan

  assert {
    condition     = aws_ssm_parameter.this["db_password"].name == "/test/example/db_password"
    error_message = "Parameter name must be /<environment>/<name>/<key>."
  }

  assert {
    condition     = output.name == "/test/example"
    error_message = "name output must be the path prefix."
  }

  assert {
    condition     = aws_ssm_parameter.this["db_password"].tags.Team == "core"
    error_message = "Parameter must carry merged tags."
  }
}

run "test_securestring_default" {
  command = plan

  assert {
    condition     = aws_ssm_parameter.this["db_password"].type == "SecureString"
    error_message = "type must default to SecureString."
  }

  assert {
    condition     = aws_ssm_parameter.this["region"].type == "String"
    error_message = "Explicit type must be honoured."
  }
}

run "test_type_validation" {
  command = plan

  variables {
    parameters = { bad = { value = "x", type = "Binary" } }
  }

  expect_failures = [var.parameters]
}

run "test_tier_validation" {
  command = plan

  variables {
    parameters = { bad = { value = "x", tier = "Premium" } }
  }

  expect_failures = [var.parameters]
}

run "test_create_false_plans_nothing" {
  command = plan

  variables {
    create = false
  }

  assert {
    condition     = length(aws_ssm_parameter.this) == 0
    error_message = "No parameters may be planned when create is false."
  }

  assert {
    condition     = output.id == null && output.name == null && output.arn == null
    error_message = "id, name and arn must be null when create is false."
  }

  assert {
    condition     = length(output.names) == 0
    error_message = "names must be empty when create is false."
  }
}

run "name_validation_rejects_uppercase" {
  command = plan

  variables {
    name = "Bad-Name"
  }

  expect_failures = [var.name]
}

run "test_tags_contract" {
  command = plan

  variables {
    tags = { Owner = "x" }
    context = {
      organization = "olensys"
      environment  = "test"
      application  = "example"
      owner        = "platform"
      cost_center  = "eng"
      extra_tags   = { Owner = "y", Team = "z" }
    }
  }

  assert {
    condition     = output.tags.Owner == "x"
    error_message = "var.tags must win over context.extra_tags."
  }

  assert {
    condition     = output.tags.Team == "z"
    error_message = "context.extra_tags must be merged."
  }
}
