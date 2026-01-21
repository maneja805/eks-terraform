data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_vpc" "cluster_vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

# data "aws_subnets" "core_subnets" {
#   #   filter {
#   #     name   = "tag:Name"
#   #     values = ["*core*"]
#   #   }

#   filter {
#     name   = "vpc-id"
#     values = [data.aws_vpc.cluster_vpc.id]
#   }
# }

# //Getting subnet resource to access CIDR block values
# data "aws_subnet" "core_subnets" {
#   for_each = toset(data.aws_subnets.core_subnets.ids)
#   id       = each.value
# }

# data "aws_subnets" "cni_subnets" {
#   filter {
#     name   = "tag:Name"
#     values = ["*cni*"]
#   }

#   filter {
#     name   = "vpc-id"
#     values = [data.aws_vpc.cluster_vpc.id]
#   }

#   #   # this logic can be hardcoded once all workload clusters are migrated to the latest VPC design and the flag can be removed
#   #   dynamic "filter" {
#   #     for_each = var.enable_latest_eks_vpc ? [1] : []
#   #     content {
#   #       name   = "tag:eks_cluster_name"
#   #       values = [var.cluster_name]
#   #     }
#   #   }
# }

# Getting subnet resource to access CIDR block values
# data "aws_subnet" "cni_subnets" {
#   for_each = toset(data.aws_subnets.cni_subnets.ids)
#   id       = each.value
# }