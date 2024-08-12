# Get AWS region
data "aws_region" "current" {}

# Get AWS account id
data "aws_caller_identity" "current" {}

# Get AWS region AZs
data "aws_availability_zones" "az" {
  state = "available"
}

# Get latest AML2 AMI id
data "aws_ssm_parameter" "aml_latest_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

# Get AWS Organizations id
data "aws_organizations_organization" "this" {}

# Get AWS IAC instance id
data "aws_ssoadmin_instances" "this" {}

# Get an Identity Store user
data "aws_identitystore_user" "this" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
  for_each          = toset(var.user_list)

  alternate_identifier {
    unique_attribute {
      attribute_path  = "UserName"
      attribute_value = each.value
    }
  }
}

