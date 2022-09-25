resource "local_file" "kubeconfig" {
  depends_on = [linode_lke_cluster.foobar]
  filename   = "kube-config"
  content    = base64decode(linode_lke_cluster.foobar.kubeconfig)
}