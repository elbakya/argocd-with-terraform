output "eks_cluster_name" {
  value = var.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_auth_data" {
  value = module.eks.cluster_certificate_authority_data
}
