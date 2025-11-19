# variable "resource_group_name" {
#   type        = string
#   description = "Name of the Resource Group"
# }

# variable "key_vault_name" {
#   description = "The name of the Key Vault"
#   type        = string
#   default = ""
# }

# variable "key_name" {
#   description = "The name of the Key for"
#   type        = string
#   default = ""
# }

# variable "key_type" {
#   description = "The type of the Key Vault key."
#   type        = string
#   default     = "RSA"
# }

# variable "key_size" {
#   description = "The size of the Key Vault key."
#   type        = number
#   default     = 2048
# }

# variable "key_opts" {
#   description = "The key options for the Key Vault key."
#   type        = list(string)
#   default     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
# }

# variable "time_before_expiry" {
#   description = "Time before expiry for automatic rotation."
#   type        = string
#   default     = "P30D"
# }

# variable "expire_after" {
#   description = "Time after which the key expires."
#   type        = string
#   default     = "P90D"
# }

# variable "notify_before_expiry" {
#   description = "Time before expiry to notify."
#   type        = string
#   default     = "P29D"
# }
