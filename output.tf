resource "local_file" "kubeconfig" {
  depends_on = [linode_lke_cluster.foobar]
  filename   = "kube-config"
  content    = base64decode(linode_lke_cluster.foobar.kubeconfig)
}

output "kubeconfig" {
   value = linode_lke_cluster.foobar.kubeconfig
   sensitive = true
}

output "api_endpoints" {
   value = linode_lke_cluster.foobar.api_endpoints
}

output "status" {
   value = linode_lke_cluster.foobar.status
}

output "id" {
   value = linode_lke_cluster.foobar.id
}

output "pool" {
   value = linode_lke_cluster.foobar.pool
}
