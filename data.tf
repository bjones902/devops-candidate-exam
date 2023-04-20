data "aws_nat_gateway" "nat" {
  id = "nat-04bad8be564a37c70"
}

data "aws_vpc" "vpc" {
  id = "vpc-00bf0d10a6a41600c"
}

data "aws_iam_role" "lambda" {
  name = "DevOps-Candidate-Lambda-Role"
}

data "archive_file" "lambda" {
  type = "zip"
  source_file = "invokeAPI.py"
  output_path = "inovokeAPI_payload.zip"
}
