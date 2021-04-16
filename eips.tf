resource "aws_eip" "nat_1a" {
    depends_on = [aws_internet_gateway.eks]

    tags = {
        Name = "grayson-eks"
    }
}

resource "aws_eip" "nat_1b" {
    depends_on = [aws_internet_gateway.eks]

    tags = {
        Name = "grayson-eks"
    }
}