generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents = <<EOF
terraform {
  required_providers {
    authentik = {
      source = "goauthentik/authentik"
      version = "2024.8.3"
    }
  }
}

provider "authentik" {
  # Configuration options
  url   = "${get_env("AUTHENTIK_URL")}"
  token = "${get_env("AUTHENTIK_TOKEN")}"
}
EOF
}

# For initial setup, we will use the local backend
# remote_state {
#   backend = "local"
#   generate = {
#     path = "backend.tf"
#     if_exists = "overwrite"
#   }
#   config = {
#     path = "${path_relative_to_include()}/terraform.tfstate"
#   }
# }

remote_state {
  backend = "azurerm"
  generate = {
    path = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    # use_azuread_auth = true # Currently use account that connected to az cli
    storage_account_name  = "portiertfstate"
    container_name        = "staging"
    key                   = "authentik/${path_relative_to_include()}/terraform.tfstate"
    resource_group_name   = "portier-cloud-production"
  }
}
