variable "location" {
  type        = string
  description = "Region for the infrastructure deployment"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the Resource Group"
}

variable "afd_name" {
  type        = string
  description = "Name of the Front Door"
}

variable "afd_sku_name" {
  type        = string
  description = "Name of the SKU for Front Door"
}

variable "custom_domains" {
  type = list(object({
    name       = string
    host_name  = string
    tls        = object({
      certificate_type          = string
       minimum_tls_version = string
      key_vault_certificate_id  = string

    })
  }))
}

variable "endpoints" {
  type = list(object({
    name    = string
    enabled = bool
  }))
}

variable "routes" {
  type = list(object({
    name                  = string
    endpoint_name         = string
    origin_group_name     = string
    origins_names         = list(string)
    forwarding_protocol   = string
    patterns_to_match     = list(string)
    supported_protocols   = list(string)
    custom_domains_names  = list(string)
    rule_sets_names       = list(string)
  }))
}

variable "origin_groups" {
  type = list(object({
    name          = string
    health_probe  = object({
      interval_in_seconds  = number
      path                 = string
      protocol             = string
      request_type         = string
    })
    load_balancing = object({
      successful_samples_required = number
      sample_size                        = number
      additional_latency_in_milliseconds = number
    })
  }))
}

variable "origins" {
  type = list(object({
    name                            = string
    origin_group_name               = string
    enabled                       = bool
    certificate_name_check_enabled  = bool
    host_name                       = string
    http_port = number
    https_port = number
    priority = number
    weight = number
  }))
}

variable "rule_sets" {
  type = list(object({
    rulesetname                  = string
     }))
}

variable "rules" {
  type = list(object({
    name                 = string
    order                = number
     behavior_on_match         = string
    actions = object({
      route_configuration_override_action = list(object({
        forwarding_protocol = string
        }))
      
    })
    conditions = object({
      host_name_condition = list(object({
       match_values     = list(string)
        operator = string
      }))
    })
  }))
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
    default = {
    ApplicationName    = "AIML-Vardo"
    BusinessUnit       = "AIML"
    CI                 = "Subscription"
    CostCenter         = "TBD"
    Environment        = "NONPROD"
    ITApplicationOwner = "brian.dolan@fortrea.com"
  }
}