# Define an AWS Security Group within Terraform, associated with a specified VPC.
resource "aws_security_group" "sg_custom" {
    # Associate the security group with the ID of the custom VPC previously defined.
    vpc_id = aws_vpc.custom_vpc.id

    # Define the egress (outbound) rules for the security group. 
    egress {  # Allows all outbound traffic from this security group.
        from_port   = 0        # Starting port range (0 indicates all ports).
        to_port     = 0        # Ending port range (0 indicates all ports).
        protocol    = -1       # Protocol number (-1 indicates all protocols).
        cidr_blocks = ["0.0.0.0/0"] # Allowed destination CIDR block (0.0.0.0/0 represents all IPs).
    }

    # Define ingress (inbound) rules for allowing SSH access to instances.
    ingress {  # Defines inbound rule for SSH.
        from_port   = 22       # The port for SSH traffic.
        to_port     = 22       # The same as from_port since it's targeting a single port.
        protocol    = "tcp"    # The protocol used for SSH.
        cidr_blocks = [ "0.0.0.0/0" ] # Allowed source IP range for this traffic.
    }

    # Define ingress rules for allowing HTTP access.
    ingress {  # Defines inbound rule for HTTP.
        from_port   = 80       # Port for HTTP traffic.
        to_port     = 80       # Targeting the standard port for HTTP.
        protocol    = "tcp"    # The protocol used for HTTP.
        cidr_blocks = [ "0.0.0.0/0" ] # Allow all IPs to connect over HTTP.
    }

    # Define ingress rules for allowing HTTPS access.
    ingress {  # Defines inbound rule for HTTPS.
        from_port   = 6443     # Port for HTTPS traffic for Kubernetes API server.
        to_port     = 6443     # Targeting a specific port for the service.
        protocol    = "tcp"    # The protocol used for HTTPS.
        cidr_blocks = [ "0.0.0.0/0" ] # Allow all IPs secure web traffic.
    }

    # Define ingress rules for other specific application/service.
    ingress {  # Additional rule for application-specific access.
        from_port   = 2379     # Application-specific port (etcd client requests).
        to_port     = 2379     # Specific to a service running on this port.
        protocol    = "tcp"    # The protocol used by the service.
        cidr_blocks = [ "0.0.0.0/0" ] # Open to all IPs for this service.
    }

    # Assign tags to the security group for better resource management and identification.
    tags = {
        "Name"        = "sg_custom"          # Name tag for the security group.
        "Description" = "sg_custom"          # Description for additional context.
    }
}
