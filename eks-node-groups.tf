resource "aws_iam_role" "eks_cluster_node_group" {
    name = "grayson-eks-cluster-node-group"
    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role = aws_iam_role.eks_cluster_node_group.name
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    role = aws_iam_role.eks_cluster_node_group.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only_policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role = aws_iam_role.eks_cluster_node_group.name
}

resource "aws_eks_node_group" "main" {
    cluster_name = aws_eks_cluster.eks.name
    node_group_name = "main"
    node_role_arn = aws_iam_role.eks_cluster_node_group.arn
    subnet_ids = [ # only private for cluster, public subnets used for LB's
        aws_subnet.private_1a.id,
        aws_subnet.private_1b.id
    ]
    scaling_config {
        desired_size = 2
        max_size = 3
        min_size = 1
    }
    ami_type = "AL2_x86_64"
    capacity_type = "ON_DEMAND" # pay be the second, more reliable than SPOT (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-spot-instances.html)
    disk_size = 15 # GiB
    force_update_version = false # force update if existing pods cannot be drained due to pod disruption budget issue
    instance_types = ["t3.small"]
    labels = {
        role = "main"
    }
    version = "1.18" # inherited from master plane otherwise
    depends_on = [
        aws_iam_role_policy_attachment.amazon_eks_worker_node_policy,
        aws_iam_role_policy_attachment.amazon_eks_cni_policy,
        aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only_policy
    ]
}