resource "aws_lambda_function" "lambda_func" {
  function_name = "${var.env_name}-extractor"
  timeout       = 20 # seconds
  image_uri     = docker_image.image.name
  package_type  = "Image"

  role = aws_iam_role.lambda_exec_role.arn

  environment {
    variables = {
      ENVIRONMENT           = var.env_name,
      SPOTIPY_CLIENT_ID     = var.spotipy_client_id,
      SPOTIPY_CLIENT_SECRET = var.spotipy_client_secret
    }
  }
  depends_on = [
    aws_s3_bucket.bucket
  ]
}
