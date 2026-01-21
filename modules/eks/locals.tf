
locals {
  all_principal_arns = distinct(concat(var.principal_arns, [tolist(data.aws_iam_roles.platform_engineer_role.arns)[0]]))
}
