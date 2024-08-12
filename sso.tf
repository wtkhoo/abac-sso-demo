
# Enable ABAC and map user attribute
resource "aws_ssoadmin_instance_access_control_attributes" "abac_demo" {
  instance_arn = tolist(data.aws_ssoadmin_instances.this.arns)[0]

  attribute {
    key = "Department"
    value {
      source = ["$${path:enterprise.department}"]
    }
  }

  # attribute {
  #   key = "CostCenter"
  #   value {
  #     source = ["$${path:enterprise.costCenter}"]
  #   }
  # }
}

# Create a demo permission set
resource "aws_ssoadmin_permission_set" "abac_demo" {
  instance_arn     = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  name             = "ABACdemo"
  description      = "Attribute-based access control demonstration"
}

# Create an inline permission set policy
resource "aws_ssoadmin_permission_set_inline_policy" "abac_demo" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.abac_demo.arn

  inline_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "ReadOnlyAccess"
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeImages",
          "ec2:DescribeVolumes",
          "ec2:DescribeTags",
          "ec2:DescribeSnapshots"
        ]
        Resource = "*"
      },
      {
        Sid    = "ConditionalStartStop"
        Effect = "Allow"
        Action = [
          "ec2:StartInstances",
          "ec2:StopInstances"
        ]
        Resource = "*"
        Condition = {
          "StringEquals" = {
            "aws:ResourceTag/Department" = "$${aws:PrincipalTag/Department}"
          }
        }
      }
    ]
  })
}

# Associate users and permission set to an AWS account
resource "aws_ssoadmin_account_assignment" "abac_demo" {
  for_each           = data.aws_identitystore_user.this
  instance_arn       = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.abac_demo.arn

  principal_id   = each.value.user_id
  principal_type = "USER"
  target_id      = var.account_id
  target_type    = "AWS_ACCOUNT"
}

