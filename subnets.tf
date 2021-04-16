resource "aws_subnet" "public_1a" {
    vpc_id = aws_vpc.eks.id
    cidr_block = "10.100.1.0/24"
    availability_zone = "us-east-1a"

    map_public_ip_on_launch = true

    tags = {
        Name    = "grayson-eks-public-1a"
        "kubernetes.io/cluster/eks" = "shared"
        "kubernetes.io/role/elb"    = 1
    }
}

resource "aws_subnet" "private_1a" {
    vpc_id = aws_vpc.eks.id
    cidr_block = "10.100.10.0/24"
    availability_zone = "us-east-1a"

    tags = {
        Name    = "grayson-eks-private-1a"
        "kubernetes.io/cluster/eks" = "shared"
        "kubernetes.io/role/internal-elb"    = 1
    }
}

resource "aws_subnet" "public_1b" {
    vpc_id = aws_vpc.eks.id
    cidr_block = "10.100.2.0/24"
    availability_zone = "us-east-1b"

    map_public_ip_on_launch = true

    tags = {
        Name    = "grayson-eks-public-1b"
        "kubernetes.io/cluster/eks" = "shared"
        "kubernetes.io/role/elb"    = 1
    }
}

resource "aws_subnet" "private_1b" {
    vpc_id = aws_vpc.eks.id
    cidr_block = "10.100.20.0/24"
    availability_zone = "us-east-1b"

    tags = {
        Name    = "grayson-eks-private-1b"
        "kubernetes.io/cluster/eks" = "shared"
        "kubernetes.io/role/internal-elb"    = 1
    }
}