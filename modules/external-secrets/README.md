# tf-aws-external-secrets
## Introduction
This sub-module is used to deploy External Secrets on the standard EKS module.


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | A Custom name for the EKS cluster | `string` | n/a | yes |
| <a name="input_external_secrets_cluster_secrets_namespace"></a> [external\_secrets\_cluster\_secrets\_namespace](#input\_external\_secrets\_cluster\_secrets\_namespace) | The name of the Kubernetes namespace for the ClusterSecretStore | `string` | `"cluster-secrets"` | no |
| <a name="input_external_secrets_cluster_service_account"></a> [external\_secrets\_cluster\_service\_account](#input\_external\_secrets\_cluster\_service\_account) | The name of the service account used for the ClusterSecretStore | `string` | `"cluster-external-secretstore"` | no |
| <a name="input_external_secrets_service_account"></a> [external\_secrets\_service\_account](#input\_external\_secrets\_service\_account) | Service account name for the external-secrets Controller | `string` | `"secrets-manager"` | no |
| <a name="input_oidc_provider_arn"></a> [oidc\_provider\_arn](#input\_oidc\_provider\_arn) | OIDC provider ARN associated with EKS cluster | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for AWS resources | `map(string)` | `{}` | no |
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_irsa"></a> [irsa](#module\_irsa) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | 5.59.0 |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_external_secrets_cluster_role_arn"></a> [external\_secrets\_cluster\_role\_arn](#output\_external\_secrets\_cluster\_role\_arn) | External Secrets IRSA role ARN |
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