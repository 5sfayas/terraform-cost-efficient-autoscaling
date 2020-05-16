#create a role for lamda access aws resouces
resouce "aws_iam_role" "lamda-iam"{
	#role name
	name="lamda-asg"
	
	#assume role to a services
	assume_role_policy =<<EOF
	{
		"Version": "2012-10-17",
		"Statement": [
		{
			"Action": "sts:AssumeRole",
			"Principal": {
			"Service": "lambda.amazonaws.com"
		},
		"Effect": "Allow",
		"Sid": ""
    }
		]
	}
EOF
}
# create policy for role to assume autoscaling
resource "aws_iam_role_policy" "autoscaling-lambda-policy"{
	name = "autoscaling_lambda_policy"
	role = "${aws_iam_role.lamda-iam.id}"

	policy = <<EOF
	{
		"Version": "2012-10-17",
		"Statement": [
		{
			"Effect": "Allow",
			"Action": [
			"autoscaling:*"
			],
			"Resource": "*"
		}
		]
	}
	EOF
}
