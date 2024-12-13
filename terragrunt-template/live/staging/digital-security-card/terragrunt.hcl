
include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/authentik_application"
}

inputs = {
  name = "Digital Security Card"
  slug = "digital-security-card"
  # authentication_flow = "default-authentication-flow"
  # authorization_flow = "default-provider-authorization-implicit-consent"
  redirect_uris = ["https://example-app.com/auth/callback"]
  meta_launch_url = "https://example-app.com"
}