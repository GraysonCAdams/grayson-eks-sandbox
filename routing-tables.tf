resource "aws_route_table" "public" {
    vpc_id = aws_vpc.eks.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.eks.id
    }
    tags = {
        Name = "grayson-eks-public"
    }
}

resource "aws_route_table" "private_1a" {
    vpc_id = aws_vpc.eks.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.gw_1a.id
    }
    tags = {
        Name = "grayson-eks-private-1a"
    }
}

resource "aws_route_table" "private_1b" {
    vpc_id = aws_vpc.eks.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.gw_1b.id
    }
    tags = {
        Name = "grayson-eks-private-1b"
    }
}