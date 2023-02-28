provider "hcp" {
  client_id     = var.hcp_client_id
  client_secret = var.hcp_client_secret
}


data "terraform_remote_state" "hvn" {
  backend = "remote"

  config = {
    organization = var.organization
    workspaces = {
      name = var.hvnworkspace
    }
  }
}


resource "hcp_consul_cluster" "consulcluster" {
  cluster_id = "consul-cluster"
  hvn_id     = data.terraform_remote_state.hvn.outputs.hvn_id
  tier       = var.tier
}