output "application_id" {
  value = authentik_application.app.id
}

# output "oauth2_provider_id" {
#   value = authentik_provider_oauth2.provider.id
# }

# output "client_id" {
#   value = authentik_provider_oauth2.provider.client_id
# }

# output "client_secret" {
#   value     = authentik_provider_oauth2.provider.client_secret
#   sensitive = true
# }