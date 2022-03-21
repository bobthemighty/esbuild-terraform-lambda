resource aws_lambda_function lambda {
  filename      = var.package_filename
  function_name = var.lambda_function_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = var.lambda_handler

  source_code_hash = filebase64sha256(var.package_filename)

  runtime = "nodejs14.x"

  tags = {
    project = var.project_name
  }
}

data aws_iam_policy_document assumption_policy {
  statement {
    sid = "assumeRole"

    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource aws_iam_role iam_for_lambda {
  name = "${var.lambda_function_name}-executor"
  assume_role_policy = data.aws_iam_policy_document.assumption_policy.json


  inline_policy {
    name   = "allow-cloudwatch-logs"
    policy = data.aws_iam_policy_document.cloudwatch_logs.json
  }
}
