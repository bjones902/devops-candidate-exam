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
  count          = 1
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = data.aws_nat_gateway.nat.id
}

resource "aws_lambda_function" "invokeAPI_lambda" {
  filename      = "inovokeAPI_payload.zip"
  function_name = "invokeAPI"
  role          = data.aws_iam_role.lambda.arn
  handler       = "index.test"
  runtime       = "python3.7"
}
