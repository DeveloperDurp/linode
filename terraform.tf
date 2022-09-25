terraform {
  backend "http" {} 
  required_providers {
    linode = {
        source = "linode/linode"
        version = "1.27.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.0.3"
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
}

provider "kubernetes" {
  config_path    = local_file.kubeconfig.filename
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}
