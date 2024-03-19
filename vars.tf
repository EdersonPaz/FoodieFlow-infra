variable "regionDefault" {
  default     = "us-east-1"
  description = "aws region"
}

variable "projectName" {
  default     = "foodieflow"
  description = "project name"
}

variable "app_namespace" {
  description = "In Kubernetes, namespaces provides a mechanism for isolating groups of resources within a single cluster."
  default     = "app"
  type        = string
}

variable "serviceaccount_name" {
  description = "A service account provides an identity for processes that run in a Pod, and maps to a ServiceAccount object."
  default     = "aws-iam-serviceaccount"
  type        = string
}

variable "cluster_name" {
  description = "A service account provides an identity for processes that run in a Pod, and maps to a ServiceAccount object."
  default     = module.eks.cluster_name
  type        = string
}