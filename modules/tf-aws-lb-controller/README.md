# tf-aws-lb-controller
## Introduction
This sub-module is used to deploy the AWS Load Balancer Controller on the standard EKS module.


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | A Custom name for the EKS cluster | `string` | n/a | yes |
| <a name="input_lb_service_account"></a> [lb\_service\_account](#input\_lb\_service\_account) | Service account name for the LoadBalancer Controller | `string` | `"aws-load-balancer-controller"` | no |
| <a name="input_oidc_provider_arn"></a> [oidc\_provider\_arn](#input\_oidc\_provider\_arn) | OIDC provider ARN associated with EKS cluster | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region where resources are spinned up | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for AWS resources | `map(string)` | `{}` | no |
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lb_iam_role"></a> [lb\_iam\_role](#module\_lb\_iam\_role) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | 5.59.0 |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_lb_controller_role_arn"></a> [aws\_lb\_controller\_role\_arn](#output\_aws\_lb\_controller\_role\_arn) | AWS Load Balancer Controller IRSA role ARN |
## Providers

No providers.
## Requirements

No requirements.
## Resources

No resources. 