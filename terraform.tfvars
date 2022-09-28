label = "main-cluster"
k8s_version = "1.23"
region = "us-central"
pools = [
  {
    type : "g6-standard-1"
    count : 1
    max : 5
  }
]
