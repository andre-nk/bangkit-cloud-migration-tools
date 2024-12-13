data "authentik_brand" "default" {
  domain = "authentik-default"
}

import {
  to = authentik_brand.default
  id = data.authentik_brand.default.id
}

resource "authentik_brand" "default" {
  domain         = "authentik-default"
  default        = true
  branding_title = "portier Global"
  branding_logo = "https://portier.de/wp-content/uploads/2024/02/Kaddy-Box-R-Colour-Orange-1.png"
  branding_favicon = "https://portier.de/wp-content/uploads/2024/04/cropped-favicon-Portier.png"
  flow_authentication = data.authentik_brand.default.flow_authentication
  flow_invalidation = data.authentik_brand.default.flow_invalidation
  flow_user_settings = data.authentik_brand.default.flow_user_settings
}