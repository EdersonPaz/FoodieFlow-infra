module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.5"


  name = "main"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Environment = "staging"
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  # Necessário no Kubernetes
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }
  map_public_ip_on_launch = true
}