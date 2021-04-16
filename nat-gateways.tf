resource "aws_nat_gateway" "gw_1a" {
    # IP address to assign
    allocation_id = aws_eip.nat_1a.id

    subnet_id = aws_subnet.public_1a.id

    tags = {
        Name = "grayson-eks-gw-1a"
    }
}

resource "aws_nat_gateway" "gw_1b" {
    # IP address to assign
    allocation_id = aws_eip.nat_1b.id

    subnet_id = aws_subnet.public_1b.id

    tags = {
        Name = "grayson-eks-gw-1b"
    }
}