# Define an AWS subnet resource within Terraform.
resource "aws_subnet" "public_subnet" {
  # Associate this subnet with the ID of a previously defined custom VPC.
  vpc_id = aws_vpc.custom_vpc.id

  # Set the CIDR block for the subnet, determining its size and IP address range.
  cidr_block = "10.0.2.0/24"

  # Specify the Availability Zone in which the subnet will reside.
  availability_zone = "us-east-1a"

  # Automatically assign public IP addresses to instances launched in this subnet.
  map_public_ip_on_launch = true

  # Apply tags to the subnet resource for identification and organization.
  tags = {
    "Name" = "10.0.2.0 - us-east-1a"
  }
}






