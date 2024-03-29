variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "hcp_client_id" {
  description = "The HCP Client ID"
  type        = string
  sensitive   = false
}

variable "hcp_client_secret" {
  description = "The HCP Client Secret (sensitive)"
  type        = string
  sensitive   = true
}

variable "cluster_id" {
  type    = string
  default = "demo-consul"
}


variable "organization" {
  type = string
  default = "carstenduch"
}

variable "hvnworkspace" {
  type = string
  default = "HCP_HVN"
}