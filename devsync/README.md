# DevSync AWS Infrastructure (Terraform)

This directory contains the first-pass Terraform infrastructure for the DevSync practice project.

## What it creates

- One VPC with DNS support and hostnames
- One public subnet in the first available Availability Zone in the selected region
- An Internet Gateway and public route table
- A Jenkins EC2 instance
- An application EC2 instance
- Separate security groups for Jenkins and the application host

The instances use the latest matching Canonical Ubuntu 24.04 LTS x86_64 AMI, encrypted gp3 root volumes, and IMDSv2-required instance metadata.

## Security notes

- SSH (port 22) is limited to the administrator CIDR you configure.
- Jenkins UI (port 8080) is limited to that same administrator CIDR.
- HTTP (port 80) on the application host is public.
- Database ports are not opened publicly by this configuration.
- No application secrets, SSH private keys, AWS credentials, or real terraform.tfvars file belong in this repository.
- Jenkins, Docker, Ansible, the application, TLS, and runtime secrets are not installed/configured by this Terraform configuration.

Use your own current public IPv4 address with a /32 mask for admin_cidr. If your public IP changes, update the local variable file and apply the reviewed change.

## Prerequisites

- Terraform 1.5 or newer
- AWS CLI configured with credentials for the intended AWS account
- An existing EC2 key pair in the selected AWS region
- Permission to create VPC, subnet, route, security group, and EC2 resources

## Configure

From this directory:

    cp terraform.tfvars.example terraform.tfvars

Edit terraform.tfvars. Replace admin_cidr with your public IPv4 address and /32, and replace key_name with the name of an existing EC2 key pair in the selected region. Do not commit terraform.tfvars.

Confirm the AWS identity before doing anything that creates resources:

    aws sts get-caller-identity

Check that the account ID is the account you intend to use.

## Validate and review

Run these commands from this directory:

    terraform init
    terraform fmt -recursive
    terraform validate
    terraform plan -out=tfplan

Read the entire plan and confirm the account, region, resource types, and estimated costs before applying. A plan is not a cost estimate guarantee; check current AWS pricing for your region and instance types.

Only create resources after you have reviewed the plan:

    terraform apply tfplan

This project configuration creates billable AWS resources. EC2 instances, EBS volumes, public IPv4 addresses, and other resources may incur charges while running. Stop or destroy resources when finished, and verify the AWS console afterward. Do not run apply automatically from CI.

## Inspect outputs

    terraform output

The Jenkins URL is only an address; Terraform does not install Jenkins. Similarly, the application URL will not serve DevSync until the application host is configured and the app is deployed.

## Cleanup

When you are certain these resources are no longer needed, review the destruction plan:

    terraform plan -destroy

If it lists only resources you intend to remove, destroy them:

    terraform destroy

Terraform state is required to manage and destroy resources safely. Keep it private and backed up securely; do not commit state files. If resources were created outside this state, inspect and clean them up separately.

## Design limitations / next steps

This is a practice-oriented starting point, not a production-ready architecture. Both instances are in a public subnet, and the application HTTP endpoint has no TLS. For production, consider private subnets, controlled egress, HTTPS, a load balancer, centralized secrets, backups, monitoring, and a remote encrypted state backend with locking.

The default t3.small instance sizes are cost-conscious starting values, but Jenkins and the full multi-container application may need more memory. Check the workload and regional prices before deployment.
