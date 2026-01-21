variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-west-2"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
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

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}

variable "environment" {
  description = "Deployment environment (e.g., sb, dev, sit, uat, prod)"
  type        = string
}

variable "argocd_helm_chart_version" {
  type        = string
  description = "Helm chart version of ArgoCD"
  default     = "7.3.3"

}

variable "custom_domain" {
  description = "Custom domain to overwrite aws3.uk.tsb"
  default     = "eks.iam.poc"
  type        = string
}

variable "enable_external_dns" {
  description = "Flag to enable or disable external DNS"
  type        = bool
  default     = true

}

variable "partition" {
  type    = string
  default = "aws"
}