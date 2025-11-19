resource "azurerm_cdn_frontdoor_profile" "cdnfd" {
  name                = var.afd_name
  resource_group_name = var.resource_group_name
  sku_name            = var.afd_sku_name
  tags = var.tags
}

resource "azurerm_cdn_frontdoor_endpoint" "fdep" {
  for_each            = { for endpoint in var.endpoints : endpoint.name => endpoint }
  name                = each.value.name
  cdn_frontdoor_profile_id    = azurerm_cdn_frontdoor_profile.cdnfd.id
  enabled             = each.value.enabled

  depends_on = [
    azurerm_cdn_frontdoor_profile.cdnfd
  ]

}

# resource "azurerm_cdn_frontdoor_custom_domain" "afdcustomdomain" {
#   for_each            = { for domain in var.custom_domains : domain.name => domain }
#   name                = each.value.name
#   cdn_frontdoor_profile_id    = azurerm_cdn_frontdoor_profile.cdnfd.id
#   host_name           = each.value.host_name
#   tls {
#     certificate_type         = each.value.tls.certificate_type
#     minimum_tls_version = each.value.tls.minimum_tls_version
#   }
# }

resource "azurerm_cdn_frontdoor_origin_group" "fdorigingrp" {
  for_each            = { for group in var.origin_groups : group.name => group }
  name                = each.value.name
  cdn_frontdoor_profile_id    = azurerm_cdn_frontdoor_profile.cdnfd.id
  health_probe {
    interval_in_seconds = each.value.health_probe.interval_in_seconds
    path                = each.value.health_probe.path
    protocol            = each.value.health_probe.protocol
    request_type        = each.value.health_probe.request_type
  }
  load_balancing {
    successful_samples_required = each.value.load_balancing.successful_samples_required
    sample_size                        = each.value.load_balancing.sample_size
    additional_latency_in_milliseconds = each.value.load_balancing.additional_latency_in_milliseconds
  }

    depends_on = [
    azurerm_cdn_frontdoor_profile.cdnfd
  ]
}

resource "azurerm_cdn_frontdoor_origin" "fdorigin" {
  for_each            = { for origin in var.origins : origin.name => origin }
  name                = each.value.name
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.fdorigingrp[each.value.origin_group_name].id
  enabled                       = each.value.enabled
  host_name           = each.value.host_name
  certificate_name_check_enabled = each.value.certificate_name_check_enabled
  http_port = each.value.http_port
  https_port = each.value.https_port
  priority = each.value.priority
  weight = each.value.weight

    depends_on = [
    azurerm_cdn_frontdoor_profile.cdnfd
  ]
}

resource "azurerm_cdn_frontdoor_rule_set" "fdruleset" {
  for_each            = { for rule_set in var.rule_sets : rule_set.rulesetname => rule_set }
  name                = each.value.rulesetname
  cdn_frontdoor_profile_id    = azurerm_cdn_frontdoor_profile.cdnfd.id

    depends_on = [
    azurerm_cdn_frontdoor_profile.cdnfd
  ]
}

# resource "azurerm_cdn_frontdoor_rule" "fdrule" {
  
# for_each            = { for rule in var.rules : rule.name => rule }

#   name                      = each.value.name
#   cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.fdruleset[each.value.rulesetname].id
#   order                     = each.value.order
#   behavior_on_match         = each.value.behavior_on_match

#   actions {
#     route_configuration_override_action {
#       cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.fdorigingrp[each.value.name].id
#       forwarding_protocol           = each.value.forwarding_protocol
#       }
#   }

#   conditions {
#     host_name_condition {
#       operator         = each.value.operator
#       match_values     = each.value.match_values
#          }

#     is_device_condition {
#       operator         = each.value.operator
#       negate_condition = each.value.negate_condition
#       match_values     = each.value.match_values
#     }
#   }

#      depends_on = [
#     azurerm_cdn_frontdoor_profile.cdnfd
#   ]
# }

# resource "azurerm_cdn_frontdoor_route" "fdroute" {
#   for_each            = { for route in var.routes : route.name => route }
#   name                = each.value.name
#   cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.fdep[each.value.fdep].id
#   cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.fdorigingrp[each.value.fdorigingrp].id
#   cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.fdorigin[each.value.fdorigin].id]
#   cdn_frontdoor_rule_set_ids    = [azurerm_cdn_frontdoor_rule_set.fdruleset[each.value.fdruleset].id]
#   forwarding_protocol = each.value.forwarding_protocol
#   patterns_to_match   = each.value.patterns_to_match
#   supported_protocols = each.value.supported_protocols
#   cdn_frontdoor_custom_domain_ids = [azurerm_cdn_frontdoor_custom_domain.afdcustomdomain[each.value.name].id]

# }

# resource "azurerm_cdn_frontdoor_custom_domain_association" "domainasso1" {
#     for_each = { for domain in var.custom_domains : domain.name => domain }
#   cdn_frontdoor_custom_domain_id = azurerm_cdn_frontdoor_custom_domain.afdcustomdomain[each.key].id
#   cdn_frontdoor_route_ids        = [azurerm_cdn_frontdoor_route.fdroute[each.value.fdroute].id]
# }

