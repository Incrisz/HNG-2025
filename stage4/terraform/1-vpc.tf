# Define an AWS Virtual Private Cloud (VPC) resource within Terraform.
resource "aws_vpc" "custom_vpc" {
  # Set the CIDR block for the entire VPC, determining its overall IP address range.
  cidr_block = "10.0.0.0/16"  # IP range inside the VPC

  # Establish the instance tenancy option for the VPC. In this case, it is set to 'default', 
  # meaning instances can be launched with any tenancy.
  instance_tenancy = "default"

  # Apply tags to the VPC resource for identification and organization purposes.
  tags = {
    "Name" = "Custom_vpc"
  }
}








