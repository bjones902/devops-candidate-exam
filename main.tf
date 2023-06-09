resource "aws_subnet" "private_subnet" {
  vpc_id                  = data.aws_vpc.vpc.id
  cidr_block              = "10.0.224.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = "false"
}

resource "aws_route_table" "private" {
  vpc_id = data.aws_vpc.vpc.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = data.aws_nat_gateway.nat.id
}
resource "aws_security_group" "lambda_sg" {
  name        = "lambda_sg"
  description = "Security Group for Lambda"
  vpc_id      = data.aws_vpc.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_lambda_function" "invokeAPI_lambda" {
  filename         = "inovokeAPI_payload.zip"
  function_name    = "invokeAPI"
  role             = data.aws_iam_role.lambda.arn
  handler          = "invokeAPI.lambda_handler"
  runtime          = "python3.7"
  timeout          = "30"
  source_code_hash = data.archive_file.lambda.output_base64sha256

  vpc_config {
    security_group_ids = [aws_security_group.lambda_sg.id]
    subnet_ids         = [aws_subnet.private_subnet.id]
  }


}
