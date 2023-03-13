
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


resource "hcp_consul_cluster" "main" {
  cluster_id         = var.cluster_id
  hvn_id          = data.terraform_remote_state.hvn.outputs.hvn_id
  public_endpoint    = true
  tier               = "development"
  min_consul_version = "v1.14.0"
}

resource "hcp_consul_cluster_root_token" "token" {
  cluster_id = hcp_consul_cluster.main.id
}


output "consul_version" {
  value = hcp_consul_cluster.main.consul_version
}

output "consul_datacenter" {
  value = hcp_consul_cluster.main.datacenter
}

output "consul_cluster_id" {
  value = hcp_consul_cluster.main.cluster_id
}

output "consul_root_token" {
  value     = hcp_consul_cluster_root_token.token.secret_id
#  sensitive = true
}

output "consul_url" {
  value = "${hcp_consul_cluster.main.consul_public_endpoint_url}"

}