resource "aws_route_table_association" "public_1a" {
    subnet_id = aws_subnet.public_1a.id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_1b" {
    subnet_id = aws_subnet.public_1b.id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_1a" {
    subnet_id = aws_subnet.private_1a.id
    route_table_id = aws_route_table.private_1a.id
}

resource "aws_route_table_association" "private_1b" {
    subnet_id = aws_subnet.private_1b.id
    route_table_id = aws_route_table.private_1b.id
}