variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.30"
}

variable "ami_type" {
  type        = string
  description = "AMI type for the node"
  default     = "AL2_x86_64"
}

variable "min_size" {
  type        = string
  description = "Minimum number of nodes in the autoscaling group"
}

variable "max_size" {
  type        = string
  description = "Mazximum number of nodes in the autoscaling group"
}

variable "desired_size" {
  type        = string
  description = "Desired number of nodes in the autoscaling group"
}

variable "instance_types" {
  type        = list(string)
  description = "Type of instance for the node group"
  default     = ["t3.small"]
}

variable "purchase_option" {
  type        = string
  description = "Purchase option for the nodes"
  default     = "SPOT"
}

variable "subnet_ids" {
  description = "List of subnets for the EKS cluster"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}

variable "vpc_id" {
  description = "VPC ID for the EKS cluster"
  type        = string
}

variable "principal_arns" {
  description = "List of principal ARNs for cluster access"
  type        = list(string)

}