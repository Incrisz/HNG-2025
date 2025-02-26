# This Terraform code snippet is responsible for creating an AWS Route Table resource associated with a VPC.

# Define an AWS Route Table resource with the name 'rt_custom_internet'.
resource "aws_route_table" "rt_custom_internet" {
    # Specify the ID of the VPC in which the route table will be created.
    vpc_id = aws_vpc.custom_vpc.id # The ID is obtained from a custom VPC defined elsewhere in the Terraform configuration.

    # Define a route within the route table. 
    route {
        cidr_block = "0.0.0.0/0" # This CIDR block represents all IP addresses, enabling internet access.
        gateway_id = aws_internet_gateway.ig_custom.id # Specify the Internet Gateway to route traffic through.
    }

    # Assign tags to the Route Table to help identify and manage the resource.
    tags = {
        "Name" = "rt_custom_internet" # A Name tag with a value set to 'rt_custom_internet' for easy identification.
    }
}
