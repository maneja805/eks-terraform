module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.9.0"

  name               = var.cluster_name
  kubernetes_version = var.kubernetes_version
  subnet_ids         = var.subnet_ids
  vpc_id             = var.vpc_id
  # enable_irsa                              = true
  enable_cluster_creator_admin_permissions = true

  access_entries = { for arn in var.principal_arns :
    arn => {
      principal_arn = arn
      policy_associations = {
        admin_view = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  endpoint_public_access = true
  # Managed Node Groups
  eks_managed_node_groups = {
    worker-nodes = {
      # ami_type               = var.ami_type
      node_group_name_prefix = var.cluster_name
      instance_types         = var.instance_types
      capacity_type          = var.purchase_option
      min_size               = var.min_size
      max_size               = var.max_size
      desired_size           = var.desired_size
      subnet_ids             = var.subnet_ids

      # When a pod uses Pod Identity, it talks to a local agent on the node. 
      # For security reasons (IMDSv2), newer EKS node groups (especially with Amazon Linux 2023) block these requests 
      # if they originate from a container and have a "hop limit" of 1.
      metadata_options = {
        http_put_response_hop_limit = 2
      }

      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_type = "gp3"
            # encrypted   = true
            # kms_key_id  = module.ebs_kms_key.key_arn
          }
        }
        # xvdb = {
        #   device_name = "/dev/xvdb"
        #   ebs = {
        #     volume_size = var.ebs_volume_size
        #     volume_type = "gp3"
        #     encrypted   = true
        #     kms_key_id  = module.ebs_kms_key.key_arn
        #   }
        # }
      }
    }
  }
  # EKS Add-ons
  addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent    = true
      before_compute = true
    }
    eks-pod-identity-agent = {
      most_recent = true
    }
  }

  tags = var.tags
}


resource "null_resource" "update_kubeconfig" {
  provisioner "local-exec" {
    command = "aws eks --region eu-west-2 update-kubeconfig --name ${var.cluster_name}"
  }
  depends_on = [module.eks]
}