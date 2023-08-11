resource "aws_iam_role" "lambda_exec_role" {
  name               = "${var.env_name}-lambda-exec"
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
    resources = ["${aws_s3_bucket.bucket.arn}"]
    actions   = ["s3:ListBucket"]
  }
  statement {
    effect    = "Allow"
    resources = ["${aws_s3_bucket.bucket.arn}/*"]
    actions   = [
      "s3:PutObject",
      "s3:GetObject"
      # "s3:DeleteObject",
    ]
  }
  statement {
    effect    = "Allow"
    resources = ["*"]
    actions   = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
  }
}

resource "aws_iam_policy" "lambda_exec_role" {
  name        = "${var.env_name}-lambda-exec"
  policy      = data.aws_iam_policy_document.lambda_exec_role.json
  description = "IAM policy for the lambda function execution role"
}

resource "aws_iam_role_policy_attachment" "lambda_exec_role" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.lambda_exec_role.arn
}
