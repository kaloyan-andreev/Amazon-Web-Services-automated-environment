//Create IAM Role for EC2 Lambda Functions
resource "aws_iam_role" "iam_role_for_lambda" {
name   = "IAM-Role-for-OnlyFlights-Start_Stop_EC2-LambdaFunctions"
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

//Create IAM Role for RDS Lambda Functions
resource "aws_iam_role" "iam_role_for_lambda2" {
name   = "IAM-Role-for-OnlyFlights-RDS_Snapshots-LambdaFunctions"
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



// Create IAM Policy for EC2 Lambda Functions
resource "aws_iam_policy" "iam_policy_for_lambda" {
 
 name         = "IAM-Policy-for-OnlyFlights-LambdaFunctions"
 path         = "/"
 description  = "AWS IAM Policy for managing OnlyFlights EC2 lambda role"
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

// Create IAM Policy for RDS Lambda Functions
resource "aws_iam_policy" "iam_policy_for_lambda2" {
 
 name         = "IAM-Policy-for-OnlyFlights-RDS_Snapshots-LambdaFunctions"
 path         = "/"
 description  = "AWS IAM Policy for managing OnlyFlights RDS lambda role"
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
            "Action": "RDS:*",
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

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role2" {
 role        = "${aws_iam_role.iam_role_for_lambda2.name}"
 policy_arn  = "${aws_iam_policy.iam_policy_for_lambda2.arn}"
}


// Create a ZIP of Python Applications
// Starting instances
data "archive_file" "zip_the_python_code-start_production_instances" {
 type        = "zip"
 source_dir  = "${path.module}/python-lambda/"
 output_path = "${path.module}/python-lambda/start_Production_Instances.zip"
}

data "archive_file" "zip_the_python_code-start_monitoring_instances" {
 type        = "zip"
 source_dir  = "${path.module}/python-lambda/"
 output_path = "${path.module}/python-lambda/start_Monitoring_Instances.zip"
}

data "archive_file" "zip_the_python_code-start_backup_instances" {
 type        = "zip"
 source_dir  = "${path.module}/python-lambda/"
 output_path = "${path.module}/python-lambda/start_Backup_Instances.zip"
}

// Stopping instances
data "archive_file" "zip_the_python_code-stop_production_instances" {
 type        = "zip"
 source_dir  = "${path.module}/python-lambda/"
 output_path = "${path.module}/python-lambda/stop_Production_Instances.zip"
}

data "archive_file" "zip_the_python_code-stop_monitoring_instances" {
 type        = "zip"
 source_dir  = "${path.module}/python-lambda/"
 output_path = "${path.module}/python-lambda/stop_Monitoring_Instances.zip"
}

data "archive_file" "zip_the_python_code-stop_backup_instances" {
 type        = "zip"
 source_dir  = "${path.module}/python-lambda/"
 output_path = "${path.module}/python-lambda/stop_Backup_Instances.zip"
}

// Create snapshot
data "archive_file" "zip_the_python_code-create_RDS_snapshots" {
 type        = "zip"
 source_dir  = "${path.module}/python-lambda/"
 output_path = "${path.module}/python-lambda/create_RDS_Snapshot.zip"
}

// Create Lambda Funtion in AWS
// Lambda for starting instances 
resource "aws_lambda_function" "terraform_lambda_func-start_production_instances" {
 filename = "${path.module}/python-lambda/start_Production_Instances.zip"
 function_name = "Start_Production_Instances"
 role = "${aws_iam_role.iam_role_for_lambda.arn}"
 handler = "start_Production_Instances.lambda_handler"
 runtime = "python3.8"
 depends_on = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}

resource "aws_lambda_function" "terraform_lambda_func-start_monitoring_instances" {
 filename = "${path.module}/python-lambda/start_Monitoring_Instances.zip"
 function_name = "Start_Monitoring_Instances"
 role = "${aws_iam_role.iam_role_for_lambda.arn}"
 handler = "start_Monitoring_Instances.lambda_handler"
 runtime = "python3.8"
 depends_on = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}

resource "aws_lambda_function" "terraform_lambda_func-start_backup_instances" {
 filename = "${path.module}/python-lambda/start_Backup_Instances.zip"
 function_name = "Start_Backup_Instances"
 role = "${aws_iam_role.iam_role_for_lambda.arn}"
 handler = "start_Backup_Instances.lambda_handler"
 runtime = "python3.8"
 depends_on = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}


// Lambda for stopping instances
resource "aws_lambda_function" "terraform_lambda_func-stop_production_instances" {
 filename = "${path.module}/python-lambda/stop_Production_Instances.zip"
 function_name = "Stop_Production_Instances"
 role = "${aws_iam_role.iam_role_for_lambda.arn}"
 handler = "stop_Production_Instances.lambda_handler"
 runtime = "python3.8"
 depends_on = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}

resource "aws_lambda_function" "terraform_lambda_func-stop_monitoring_instances" {
 filename = "${path.module}/python-lambda/stop_Monitoring_Instances.zip"
 function_name = "Stop_Monitoring_Instances"
 role = "${aws_iam_role.iam_role_for_lambda.arn}"
 handler = "stop_Monitoring_Instances.lambda_handler"
 runtime = "python3.8"
 depends_on = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}

resource "aws_lambda_function" "terraform_lambda_func-stop_backup_instances" {
 filename = "${path.module}/python-lambda/stop_Backup_Instances.zip"
 function_name = "Stop_Backup_Instances"
 role = "${aws_iam_role.iam_role_for_lambda.arn}"
 handler = "stop_Backup_Instances.lambda_handler"
 runtime = "python3.8"
 depends_on = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}

// Lambda for creating snapshots 
resource "aws_lambda_function" "terraform_lambda_func-create_RDS_snapshots" {
 filename = "${path.module}/python-lambda/create_RDS_Snapshot.zip"
 function_name = "Create_RDS_Snapshot"
 role = "${aws_iam_role.iam_role_for_lambda2.arn}"
 handler = "create_RDS_Snapshot.lambda_handler"
 runtime = "python3.8"
 depends_on = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}