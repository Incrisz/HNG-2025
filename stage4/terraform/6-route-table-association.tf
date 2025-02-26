
# Define an AWS Route Table Association resource named 'rt_custom_internet_association'.
resource "aws_route_table_association" "rt_custom_internet_association" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.rt_custom_internet.id
}
