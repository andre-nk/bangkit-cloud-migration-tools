data "authentik_flow" "authorization-flow" {
  slug = var.authorization_flow
}

data "authentik_flow" "authentication-flow" {
  slug = var.authentication_flow
}

resource "authentik_provider_oauth2" "provider" {
  name               = "Provider for ${var.name}"
  client_id          = var.slug
  authorization_flow = data.authentik_flow.authorization-flow.id
  authentication_flow = data.authentik_flow.authentication-flow.id
  redirect_uris      = var.redirect_uris
}

# resource "random_password" "oauth_secret" {
#   length  = 32
#   special = false
# }

# resource "authentik_policy_expression" "policy" {
#   name       = "${var.name}-policy"
#   expression = var.policy_expression
# }

# resource "authentik_policy_binding" "app-access" {
#   target = authentik_application.app.uuid
#   policy = authentik_policy_expression.policy.id
#   order  = 0
# }

resource "authentik_application" "app" {
  name              = var.name
  slug              = var.slug
  protocol_provider = authentik_provider_oauth2.provider.id
  # meta_launch_url   = var.meta_launch_url
}
