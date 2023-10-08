resource "aws_lambda_function" "palko_lambda" {
  function_name    = "palko-lambda"
  handler          = "deployment.lambda_handler"
  runtime          = "python3.8"
  filename         = "deployment_payload.zip"
  source_code_hash = data.archive_file.deployment.output_base64sha256

  role = aws_iam_role.palko_lambda_exec.arn
}

resource "aws_iam_role" "palko_lambda_exec" {
  name = "palko-lambda-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
      },
    ],
  })
}

resource "aws_iam_policy_attachment" "palko_lambda_attach" {
  name       = "lambda_attach_policy"
  roles      = [aws_iam_role.palko_lambda_exec.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "archive_file" "deployment" {
  type        = "zip"
  source_file = "./python/deployment.py"
  output_path = "./deployment_payload.zip"
}