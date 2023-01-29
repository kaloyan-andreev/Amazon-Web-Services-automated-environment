// Create EventBridge for starting instances
// Production Instances
resource "aws_cloudwatch_event_rule" "turn_on-Production_Instances" {
    name = "Turn_On-Production_Instances-during-working-day"
    description = "Turn on Production Instances at 9:00 AM from Monday to Friday"
    schedule_expression = "cron(0 9 ? * MON-FRI *)"
}

resource "aws_cloudwatch_event_target" "turn_on-Production_Instances-during-working-days" {
    rule = "${aws_cloudwatch_event_rule.turn_on-Production_Instances.name}"
    target_id = "terraform_lambda_func-Start_Production_Instances"
    arn = "${aws_lambda_function.terraform_lambda_func-start_production_instances.arn}"
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_start_production_instances" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.terraform_lambda_func-start_production_instances.function_name}"
    principal = "events.amazonaws.com"
    source_arn = "${aws_cloudwatch_event_rule.turn_on-Production_Instances.arn}"
}

// Monitoring Instances
resource "aws_cloudwatch_event_rule" "turn_on-Monitoring_Instances" {
    name = "Turn_On-Monitoring_Instances-daily"
    description = "Turn on Monitoring Instances at 1:00 AM daily"
    schedule_expression = "cron(0 1 * * ? *)"
}

resource "aws_cloudwatch_event_target" "turn_on-Monitoring_Instances-during-working-days" {
    rule = "${aws_cloudwatch_event_rule.turn_on-Monitoring_Instances.name}"
    target_id = "terraform_lambda_func-Start_Monitoring_Instances"
    arn = "${aws_lambda_function.terraform_lambda_func-start_monitoring_instances.arn}"
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_start_monitoring_instances" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.terraform_lambda_func-start_monitoring_instances.function_name}"
    principal = "events.amazonaws.com"
    source_arn = "${aws_cloudwatch_event_rule.turn_on-Monitoring_Instances.arn}"
}

// Backup Instances
resource "aws_cloudwatch_event_rule" "turn_on-Backup_Instances" {
    name = "Turn_On-Backup_Instances-every-Sunday"
    description = "Turn on Backup Instances at 1:00 AM every Sunday"
    schedule_expression = "cron(0 1 ? * SUN *)"
}

resource "aws_cloudwatch_event_target" "turn_on-Backup_Instances-every-Sunday" {
    rule = "${aws_cloudwatch_event_rule.turn_on-Backup_Instances.name}"
    target_id = "terraform_lambda_func-Start_Backup_Instances"
    arn = "${aws_lambda_function.terraform_lambda_func-start_backup_instances.arn}"
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_start_backup_instances" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.terraform_lambda_func-start_backup_instances.function_name}"
    principal = "events.amazonaws.com"
    source_arn = "${aws_cloudwatch_event_rule.turn_on-Backup_Instances.arn}"
}



// Create EventBridge for stopping instances
// Production Instances
resource "aws_cloudwatch_event_rule" "turn_off-Production_Instances" {
    name = "Turn_Off-Production_Instances-during-working-day"
    description = "Turn off Production instances at 17:00 PM from Monday to Friday"
    schedule_expression = "cron(0 17 ? * MON-FRI *)"
}

resource "aws_cloudwatch_event_target" "turn_off-Production_Instances-during-working-days" {
    rule = "${aws_cloudwatch_event_rule.turn_off-Production_Instances.name}"
    target_id = "terraform_lambda_func-stop_production_instances"
    arn = "${aws_lambda_function.terraform_lambda_func-stop_production_instances.arn}"
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_stop_production_instances" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.terraform_lambda_func-stop_production_instances.function_name}"
    principal = "events.amazonaws.com"
    source_arn = "${aws_cloudwatch_event_rule.turn_off-Production_Instances.arn}"
}

// Monitoring Instances
resource "aws_cloudwatch_event_rule" "turn_off-Monitoring_Instances" {
    name = "Turn_Off-Monitoring_Instances-daily"
    description = "Turn off Monitoring instances at 23:00 PM daily"
    schedule_expression = "cron(0 23 * * ? *)"
}

resource "aws_cloudwatch_event_target" "turn_off-Monitoring_Instances-daily" {
    rule = "${aws_cloudwatch_event_rule.turn_off-Monitoring_Instances.name}"
    target_id = "terraform_lambda_func-stop_monitoring_instances"
    arn = "${aws_lambda_function.terraform_lambda_func-stop_monitoring_instances.arn}"
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_stop_monitoring_instances" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.terraform_lambda_func-stop_monitoring_instances.function_name}"
    principal = "events.amazonaws.com"
    source_arn = "${aws_cloudwatch_event_rule.turn_off-Monitoring_Instances.arn}"
}

// Backup Instances
resource "aws_cloudwatch_event_rule" "turn_off-Backup_Instances" {
    name = "Turn_Off-Backup_Instances-every-Sunday"
    description = "Turn off Backup instances at 3:00 AM every Sunday"
    schedule_expression = "cron(0 3 ? * SUN *)"
}

resource "aws_cloudwatch_event_target" "turn_off-Backup_Instances-every-Sunday" {
    rule = "${aws_cloudwatch_event_rule.turn_off-Backup_Instances.name}"
    target_id = "terraform_lambda_func-stop_backup_instances"
    arn = "${aws_lambda_function.terraform_lambda_func-stop_backup_instances.arn}"
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_stop_backup_instances" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.terraform_lambda_func-stop_backup_instances.function_name}"
    principal = "events.amazonaws.com"
    source_arn = "${aws_cloudwatch_event_rule.turn_off-Backup_Instances.arn}"
}