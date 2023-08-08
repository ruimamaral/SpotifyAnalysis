resource "aws_lambda_function" "lambda_func" {
  function_name = "${var.env_name}_extractor"
  timeout       = 20 # seconds
  image_uri     = docker_image.image.uri
  package_type  = "Image"
  # handler = "extract.lambda_handler"

  role = aws_iam_role.lambda_exec_role.arn

  environment {
    variables = {
      ENVIRONMENT = var.env_name,
      # SPOTIPY_CLIENT_ID     = var.spotipy_client_id,
      # SPOTIPY_CLIENT_SECRET = var.spotipy_client_secret
      # should include env variables in the dockerfile
    }
  }
  depends_on = [
    aws_s3_bucket.s3_bucket,
  ]
}
