# Deploy AWS Attribute-based Access Control (ABAC) demo environment

## Overview

This folder contains a simple project for deploying AWS environment to demonstrate AWS ABAC using AWS IAM Identity Center with Microsoft Entra ID SSO. For more details, read my [blog post](https://blog.wkhoo.com/posts/abac-sso/).

The Terraform code will deploy the AWS resources as depicted in this high level architecture diagram:

![Demo architecture](https://blog.wkhoo.com/images/abac-demo-architecture_hu454f427f895a4c219dfde62861304665_82364_800x640_fit_q50_box.jpeg)

> **Important note:** Deploying the demo environment may incur some cost in your AWS account.

## Requirements

- [Terraform](https://www.terraform.io/downloads) (>= 1.5.0)
- AWS account [configured with proper credentials to run Terraform](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration)
- A Microsoft Entra ID tenant
- AWS IAM Identity Center enabled and federated with Microsoft Entra ID SSO

## Walkthrough

1) Clone this repository to your local machine.

   ```shell
   git clone https://github.com/wtkhoo/abac-sso-demo.git
   ```

2) Change your directory to the `abac-sso-demo` folder.

   ```shell
   cd abac-sso-demo
   ```

3) Run the terraform [init](https://www.terraform.io/cli/commands/init) command to initialize the Terraform deployment and set up the providers.

   ```shell
   terraform init
   ```

4) To customize your deployment, create a `terraform.tfvars` file and specify your values.

    ```
    # AWS Account ID to map permission set
    account_id = "123456780123"
    # List of User Principal Names for permission set and AWS account association
    user_list  = ["First.User@example.com", "Second.User@example.com"]
    ```
  
5) Next step is to run a terraform [plan](https://www.terraform.io/cli/commands/plan) command to preview what will be created.

   ```shell
   terraform plan
   ```

6) If your values are valid, you're ready to go. Run the terraform [apply](https://www.terraform.io/cli/commands/apply) command to provision the resources.

   ```shell
   terraform apply
   ```

7) When you're done with the demo, run the terraform [destroy](https://www.terraform.io/cli/commands/destroy) command to delete all resources that were created in your AWS environment.

   ```shell
   terraform destroy
   ```

## Questions and Feedback

If you have any questions or feedback, please don't hesitate to [create an issue](https://github.com/wtkhoo/ssm-port-forwarding-demo/issues/new).
