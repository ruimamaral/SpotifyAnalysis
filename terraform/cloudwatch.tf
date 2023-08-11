resource "aws_cloudwatch_event_rule" "lambda_rule" {
  name                = "${var.env_name}-rule"
  description         = "Trigger Lambda function every week"
  schedule_expression = "cron(0 0 ? * * *)" # Trigger every Wednesday at 00:00 (12AM)
}

resource "aws_cloudwatch_event_target" "lambda_trigger" {
  rule = aws_cloudwatch_event_rule.lambda_rule.name
  arn  = aws_lambda_function.lambda_func.arn
}
