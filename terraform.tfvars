label = "main-cluster"
k8s_version = "1.24"
region = "us-east"
pools = [
  {
    type : "g6-standard-2"
    count : 3
    max : 3
  }
]
