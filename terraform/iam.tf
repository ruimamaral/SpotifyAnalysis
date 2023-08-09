resource "aws_iam_role" "lambda_exec_role" {
  name               = "${var.env_name}_lambda_execution"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_exec_role" {
  statement {
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = ["aws_s3_bucket.lambda_bucket.arn"]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
      # "s3:DeleteObject",
      "s3:GetObject"
    ]
    resources = ["aws_s3_bucket.lambda_bucket.arn/*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "lambda_exec_role" {
  name        = "${var.env_name}_lambda_exec_role"
  policy      = data.aws_iam_policy_document.lambda_exec_role.json
  description = "IAM policy for the lambda function execution role"
}

resource "aws_iam_role_policy_attachment" "lambda_exec_role" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.lambda_exec_role.arn
}
