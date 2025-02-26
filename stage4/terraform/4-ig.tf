
# Define an AWS Internet Gateway resource.
resource "aws_internet_gateway" "ig_custom" {
    vpc_id = aws_vpc.custom_vpc.id # Reference to the ID of the custom VPC created elsewhere.
    tags = {
        "Name" = "ig_custom" # Name tag for the internet gateway, providing an identifiable name.
    }
}
