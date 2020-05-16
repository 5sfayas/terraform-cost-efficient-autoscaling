# create lambda 
# to invoke autoscaling group
resource "aws_lambda_function" "lambda_test"{
	function_name = "lambda_stop_start_autoscaling_instances"
	filename = "./autoscaling.zip/autoscaling.py"
	role = "${aws_iam_role.lamda-iam.arn}"
	handler = "autoscaling.handler"
	runtime = "python2.7"	
}

#_______stop instances at 10pm everyday_________________
resource "aws_cloudwatch_event_rule" "stop" {
  name                = "everyday-10"
  description         = "stop instances everyday 10 pm" 
  schedule_expression = "0 0 22 1/1 * ? *"
  event_pattern = <<PATTERN
{
 "aws_region" : "eu-west-1",
    "asg_name" : "webapp",
    "min" : "0",
    "desired" : "0",
    "max" : "10"
}
PATTERN
}
resource "aws_cloudwatch_event_target" "lambda-stop" {
  rule      = "${aws_cloudwatch_event_rule.stop.name}"
  target_id = "lambda"
  arn       = "${aws_lambda_function.lambda_test.arn}"
}
resource "aws_lambda_permission" "lamda-permision" {
  statement_id  = "AllowExecutionbycloudwatchrule"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda_test.function_name}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.stop.arn}"
}
#_______end of stop instances at 10pm_________________



#_______start instances at 7am everyday_________________
resource "aws_cloudwatch_event_rule" "start" {
  name                = "everyday-7am"
  description         = "start instances everyday 7am" 
  schedule_expression = "0 0 7 1/1 * ? *"
  event_pattern = <<PATTERN
{
 "aws_region" : "eu-west-1",
    "asg_name" : "webapp",
    "min" : "2",
    "desired" : "5",
    "max" : "10"
}
PATTERN
}
resource "aws_cloudwatch_event_target" "lambda-start" {
  rule      = "${aws_cloudwatch_event_rule.start.name}"
  target_id = "lambda1"
  arn       = "${aws_lambda_function.lambda_test.arn}"
}
resource "aws_lambda_permission" "lamda-permision" {
  statement_id  = "AllowExecutionbycloudwatchrule"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda_test.function_name}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.start.arn}"
}
