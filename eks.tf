resource "aws_iam_role" "eks_cluster" {
    name = "grayson-eks-cluster"
    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role = aws_iam_role.eks_cluster.name
}

resource "aws_eks_cluster" "eks" {
    name = "grayson-eks"
    role_arn = aws_iam_role.eks_cluster.arn
    version = "1.18"
    vpc_config {
        endpoint_private_access = false
        endpoint_public_access = true
        subnet_ids = [
            aws_subnet.public_1a.id,
            aws_subnet.public_1b.id,
            aws_subnet.private_1a.id,
            aws_subnet.private_1b.id,
        ]
    }
    depends_on = [
        aws_iam_role_policy_attachment.amazon_eks_cluster_policy
    ]
}