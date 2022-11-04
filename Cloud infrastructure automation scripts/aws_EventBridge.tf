// Create EventBridge for starting maintenance instances
resource "aws_cloudwatch_event_rule" "turn-on-maintenanceEC2" {
    name = "Turn-On-MaintenancesEC2-during-working-day"
    description = "Turn on Maintenances machines at 9:00 AM from Monday to Friday"
    schedule_expression = "cron(0 9 ? * MON-FRI *)"
}

resource "aws_cloudwatch_event_target" "turn-on-maintenanceEC2-during-working-days" {
    rule = "${aws_cloudwatch_event_rule.turn-on-maintenanceEC2.name}"
    target_id = "terraform_lambda_func-start_maintenance_instances"
    arn = "${aws_lambda_function.terraform_lambda_func-start_maintenance_instances.arn}"
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_start_maintenance_instances" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.terraform_lambda_func-start_maintenance_instances.function_name}"
    principal = "events.amazonaws.com"
    source_arn = "${aws_cloudwatch_event_rule.turn-on-maintenanceEC2.arn}"
}

// Create EventBridge for stopping maintenance instances
resource "aws_cloudwatch_event_rule" "turn-off-maintenanceEC2" {
    name = "Turn-Off-MaintenancesEC2-during-working-day"
    description = "Turn off Maintenances machines at 17:00 PM from Monday to Friday"
    schedule_expression = "cron(0 17 ? * MON-FRI *)"
}

resource "aws_cloudwatch_event_target" "turn-off-maintenanceEC2-during-working-days" {
    rule = "${aws_cloudwatch_event_rule.turn-off-maintenanceEC2.name}"
    target_id = "terraform_lambda_func-stop_maintenance_instances"
    arn = "${aws_lambda_function.terraform_lambda_func-stop_maintenance_instances.arn}"
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_stop_maintenance_instances" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.terraform_lambda_func-stop_maintenance_instances.function_name}"
    principal = "events.amazonaws.com"
    source_arn = "${aws_cloudwatch_event_rule.turn-off-maintenanceEC2.arn}"
}



// Create EventBridge for starting storage instances
resource "aws_cloudwatch_event_rule" "turn-on-storageEC2" {
    name = "Turn-On-StorageEC2-during-working-day"
    description = "Turn on Storage machines at 19:00 PM from Monday to Friday"
    schedule_expression = "cron(0 19 ? * MON-FRI *)"
}

resource "aws_cloudwatch_event_target" "turn-on-storageEC2-during-working-days" {
    rule = "${aws_cloudwatch_event_rule.turn-on-storageEC2.name}"
    target_id = "terraform_lambda_func-start_storage_instances"
    arn = "${aws_lambda_function.terraform_lambda_func-start_storage_instances.arn}"
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_start_storage_instances" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.terraform_lambda_func-start_storage_instances.function_name}"
    principal = "events.amazonaws.com"
    source_arn = "${aws_cloudwatch_event_rule.turn-on-storageEC2.arn}"
}

// Create EventBridge for stopping storage instances
resource "aws_cloudwatch_event_rule" "turn-off-storageEC2" {
    name = "Turn-Off-StorageEC2-during-working-day"
    description = "Turn off Storage machines at 21:00 PM from Monday to Friday"
    schedule_expression = "cron(0 21 ? * MON-FRI *)"
}

resource "aws_cloudwatch_event_target" "turn-off-storageEC2-during-working-days" {
    rule = "${aws_cloudwatch_event_rule.turn-off-storageEC2.name}"
    target_id = "terraform_lambda_func-stop_storage_instances"
    arn = "${aws_lambda_function.terraform_lambda_func-stop_storage_instances.arn}"
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_stop_storage_instances" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.terraform_lambda_func-stop_storage_instances.function_name}"
    principal = "events.amazonaws.com"
    source_arn = "${aws_cloudwatch_event_rule.turn-off-storageEC2.arn}"
}



// Create EventBridge for starting transition instances
resource "aws_cloudwatch_event_rule" "turn-on-transitionEC2" {
    name = "Turn-On-TransitionEC2-daily"
    description = "Turn on Transition machines at 21:00 PM daily"
    schedule_expression = "cron(0 21 * * ? *)"
}

resource "aws_cloudwatch_event_target" "turn-on-transitionEC2-daily" {
    rule = "${aws_cloudwatch_event_rule.turn-on-transitionEC2.name}"
    target_id = "terraform_lambda_func-start_transition_instances"
    arn = "${aws_lambda_function.terraform_lambda_func-start_transition_instances.arn}"
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_start_transition_instances" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.terraform_lambda_func-start_transition_instances.function_name}"
    principal = "events.amazonaws.com"
    source_arn = "${aws_cloudwatch_event_rule.turn-on-transitionEC2.arn}"
}

// Create EventBridge for stopping transition instances
resource "aws_cloudwatch_event_rule" "turn-off-transitionEC2" {
    name = "Turn-Off-TransitionEC2-daily"
    description = "Turn off Transition machines at 23:00 PM daily"
    schedule_expression = "cron(0 23 * * ? *)"
}

resource "aws_cloudwatch_event_target" "turn-off-transitionEC2-daily" {
    rule = "${aws_cloudwatch_event_rule.turn-off-transitionEC2.name}"
    target_id = "terraform_lambda_func-stop_transition_instances"
    arn = "${aws_lambda_function.terraform_lambda_func-stop_transition_instances.arn}"
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_stop_transition_instances" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.terraform_lambda_func-stop_transition_instances.function_name}"
    principal = "events.amazonaws.com"
    source_arn = "${aws_cloudwatch_event_rule.turn-off-transitionEC2.arn}"
}