//Create IAM Role for Lambda Functions
resource "aws_iam_role" "iam_role_for_lambda" {
name   = "IAM-Role-for-OnlyFlights-LambdaFunctions"
assume_role_policy = <<EOF
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


// Create IAM Policy for Lambda Functions
resource "aws_iam_policy" "iam_policy_for_lambda" {
 
 name         = "IAM-Policy-for-OnlyFlights-LambdaFunctions"
 path         = "/"
 description  = "AWS IAM Policy for managing OnlyFlights lambda role"
 policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "arn:aws:logs:*:*:*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:Start*",
                "ec2:Stop*"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeInstances"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}


// Attach IAM Policy to IAM Role
resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
 role        = "${aws_iam_role.iam_role_for_lambda.name}"
 policy_arn  = "${aws_iam_policy.iam_policy_for_lambda.arn}"
}


// Create a ZIP of Python Applications
// Starting instances
data "archive_file" "zip_the_python_code-start_maintenance_instances" {
 type        = "zip"
 source_dir  = "${path.module}/python-lambda/"
 output_path = "${path.module}/python-lambda/start_maintenance_instances.zip"
}

data "archive_file" "zip_the_python_code-start_storage_instances" {
 type        = "zip"
 source_dir  = "${path.module}/python-lambda/"
 output_path = "${path.module}/python-lambda/start_storage_instances.zip"
}

data "archive_file" "zip_the_python_code-start_transition_instances" {
 type        = "zip"
 source_dir  = "${path.module}/python-lambda/"
 output_path = "${path.module}/python-lambda/start_transition_instances.zip"
}

// Stopping instances
data "archive_file" "zip_the_python_code-stop_maintenance_instances" {
 type        = "zip"
 source_dir  = "${path.module}/python-lambda/"
 output_path = "${path.module}/python-lambda/stop_maintenance_instances.zip"
}

data "archive_file" "zip_the_python_code-stop_storage_instances" {
 type        = "zip"
 source_dir  = "${path.module}/python-lambda/"
 output_path = "${path.module}/python-lambda/stop_storage_instances.zip"
}

data "archive_file" "zip_the_python_code-stop_transition_instances" {
 type        = "zip"
 source_dir  = "${path.module}/python-lambda/"
 output_path = "${path.module}/python-lambda/stop_transition_instances.zip"
}


// Create Lambda Funtion in AWS
// Lambda for starting instances 
resource "aws_lambda_function" "terraform_lambda_func-start_maintenance_instances" {
 filename = "${path.module}/python-lambda/start_maintenance_instances.zip"
 function_name = "Start_Maintenance_Instances"
 role = "${aws_iam_role.iam_role_for_lambda.arn}"
 handler = "start_maintenance_instances.lambda_handler"
 runtime = "python3.8"
 depends_on = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}

resource "aws_lambda_function" "terraform_lambda_func-start_storage_instances" {
 filename = "${path.module}/python-lambda/start_storage_instances.zip"
 function_name = "Start_Storage_Instances"
 role = "${aws_iam_role.iam_role_for_lambda.arn}"
 handler = "start_storage_instances.lambda_handler"
 runtime = "python3.8"
 depends_on = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}

resource "aws_lambda_function" "terraform_lambda_func-start_transition_instances" {
 filename = "${path.module}/python-lambda/start_transition_instances.zip"
 function_name = "Start_Transition_Instances"
 role = "${aws_iam_role.iam_role_for_lambda.arn}"
 handler = "start_transition_instances.lambda_handler"
 runtime = "python3.8"
 depends_on = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}

// Lambda for stopping instances
resource "aws_lambda_function" "terraform_lambda_func-stop_maintenance_instances" {
 filename = "${path.module}/python-lambda/stop_maintenance_instances.zip"
 function_name = "Stop_Maintenance_Instances"
 role = "${aws_iam_role.iam_role_for_lambda.arn}"
 handler = "stop_maintenance_instances.lambda_handler"
 runtime = "python3.8"
 depends_on = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}

resource "aws_lambda_function" "terraform_lambda_func-stop_storage_instances" {
 filename = "${path.module}/python-lambda/stop_storage_instances.zip"
 function_name = "Stop_Storage_Instances"
 role = "${aws_iam_role.iam_role_for_lambda.arn}"
 handler = "stop_storage_instances.lambda_handler"
 runtime = "python3.8"
 depends_on = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}

resource "aws_lambda_function" "terraform_lambda_func-stop_transition_instances" {
 filename = "${path.module}/python-lambda/stop_transition_instances.zip"
 function_name = "Stop_Transition_Instances"
 role = "${aws_iam_role.iam_role_for_lambda.arn}"
 handler = "stop_transition_instances.lambda_handler"
 runtime = "python3.8"
 depends_on = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}

