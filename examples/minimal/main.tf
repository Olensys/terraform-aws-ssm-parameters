module "this" {
  source = "../../"

  name = "example"
  context = {
    organization = "olensys"
    environment  = "test"
    application  = "example"
    owner        = "platform"
    cost_center  = "eng"
  }

  parameters = {
    greeting = { value = "hello", type = "String", description = "Example parameter" }
  }
}
