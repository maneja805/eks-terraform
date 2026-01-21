data "aws_availability_zones" "available" {}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_iam_roles" "platform_engineer_role" {
  name_regex = "AWSReservedSSO_PowerUserAccess_.*"
}