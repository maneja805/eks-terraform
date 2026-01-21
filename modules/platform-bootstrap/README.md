


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | A Custom name for the EKS cluster | `string` | n/a | yes |
| <a name="input_oidc_provider_arn"></a> [oidc\_provider\_arn](#input\_oidc\_provider\_arn) | OIDC provider ARN associated with EKS cluster | `string` | n/a | yes |
| <a name="input_platform_namespaces"></a> [platform\_namespaces](#input\_platform\_namespaces) | The names and configuration of the platform namespaces the EKS cluster require for Add-ons or Helm deployments | <pre>map(object({<br/>    secrets_manager_access                 = optional(bool, false)<br/>    rds_postgres_db                        = optional(list(string), [])<br/>    rds_postgres_user                      = optional(list(string), [])<br/>    s3_bucket_names                        = optional(list(string), [])<br/>    bedrock_foundational_model_product_ids = optional(list(string), [])<br/>    kms_key_ids                            = optional(list(string), [])<br/>    cost_centre                            = string<br/>    owner                                  = string<br/>    cpu_limits                             = optional(number, 15)<br/>    memory_limits                          = optional(number, 30)<br/>    pod_limits                             = optional(number, 50)<br/>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for the AWS resources to get added when the resources spin up | `any` | n/a | yes |
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_irsa_per_namespace"></a> [irsa\_per\_namespace](#module\_irsa\_per\_namespace) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | 5.59.0 |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_platform_namespace_role_arns"></a> [platform\_namespace\_role\_arns](#output\_platform\_namespace\_role\_arns) | ARNs for each role created for each platform namespace |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
## Requirements

No requirements.
## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.secrets_manager_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source | 