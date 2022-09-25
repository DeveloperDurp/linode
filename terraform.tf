terraform {
  backend "http" {} 
  required_providers {
    linode = {
        source = "linode/linode"
        version = "1.27.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.13.1"
    }
  }
}
//Use the Linode Provider
provider "linode" {
  token = var.token
}

//Use the linode_lke_cluster resource to create
//a Kubernetes cluster
resource "linode_lke_cluster" "foobar" {
    k8s_version = var.k8s_version
    label = var.label
    region = var.region
    tags = var.tags

    dynamic "pool" {
        for_each = var.pools
        content {
            type  = pool.value["type"]
            count = pool.value["count"]
        }
    }
    provisioner "local-exec" {
      command = "echo ${self.kubeconfig} | base64 -d >> config"
    } 
}

resource "local_file" "kubeconfig" {
  filename   = "config"
  content    = base64decode(linode_lke_cluster.foobar.kubeconfig)
}

resource "linode_nodebalancer" "foobar" {
    label = var.label
    region = var.region
    client_conn_throttle = 20
    tags = var.tags
}
