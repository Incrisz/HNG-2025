# This segment of Terraform code is used to create an internet gateway resource in AWS.

# Define an AWS Internet Gateway resource.
resource "aws_internet_gateway" "ig_custom" {
    # Associate the internet gateway with a specific VPC using its ID.
    vpc_id = aws_vpc.custom_vpc.id # Reference to the ID of the custom VPC created elsewhere.

    # Assign tags to the Internet Gateway for better resource management and identification.
    tags = {
        "Name" = "ig_custom" # Name tag for the internet gateway, providing an identifiable name.
    }
}
