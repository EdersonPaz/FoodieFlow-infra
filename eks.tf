module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.5"

  cluster_name                   = "cluster-eks-${var.projectName}"
  cluster_version                = "1.29"
  cluster_endpoint_public_access = true
  subnet_ids                     = module.vpc.public_subnets
  vpc_id                         = module.vpc.vpc_id

  eks_managed_node_groups = {
    initial = {
      instance_types = ["t2.micro"]

      min_size     = 1
      max_size     = 5
      desired_size = 2

      # Configurando a política de segurança para permitir tráfego na porta 8080
      additional_security_group_rules = [
        {
          description              = "Allow incoming traffic on port 8080"
          from_port                = 8080
          to_port                  = 8080
          protocol                 = "tcp"
          cidr_blocks              = ["0.0.0.0/0"]
          ipv6_cidr_blocks         = []
          prefix_list_ids          = []
          security_group_id        = null
          self                     = false
        }
      ]
    }
  }
}