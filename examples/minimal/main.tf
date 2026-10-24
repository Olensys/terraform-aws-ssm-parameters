terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0, < 7.0"
    }
  }
}

module "this" {
  source = "../../"

  name = "olensys-test-ssm"
  context = {
    organization = "olensys"
    environment  = "test"
    application  = "ssm"
    owner        = "platform"
    cost_center  = "eng"
  }

  parameters = {
    greeting = { value = "hello", type = "String", description = "Example parameter" }
  }
}
