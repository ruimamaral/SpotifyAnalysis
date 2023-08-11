resource "aws_cloudwatch_event_rule" "eventbridge" {
  name                = "${var.env_name}-rule"
  description         = "Trigger Lambda function every week"
  schedule_expression = "cron(0 0 ? * 3 *)" # Trigger every Wednesday at 00:00 (12AM)
}

resource "aws_cloudwatch_event_target" "lambda_trigger" {
  rule = aws_cloudwatch_event_rule.eventbridge.name
  arn  = aws_lambda_function.lambda_func.arn
}
