# create lambda 
# to invoke autoscaling group
resource "aws_lambda_function" "lambda_test"{
	function_name = "lambda_stop_start_autoscaling_instances"
	filename = "./autoscaling.zip/autoscaling.py"
	role = "${aws_iam_role.lamda-iam.arn}"
	handler = "autoscaling.handler"
	runtime = "python2.7"	
}



