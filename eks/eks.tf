module "vpc" {
  source             = "github.com/r-devops/tf-module-vpc.git"
  PROJECT_NAME       = "roboshop"
  ENV                = "prod"
  CREATE_INTERNET_GW = true
  CREATE_NAT_GW      = true
  AZ                 = ["us-east-1a", "us-east-1b"]
}

module "eks" {
  source             = "github.com/r-devops/tf-module-eks.git"
  ENV                = "prod"
  PRIVATE_SUBNET_IDS = module.vpc.PRIVATE_SUBNETS_IDS
  PUBLIC_SUBNET_IDS  = module.vpc.PUBLIC_SUBNETS_IDS
  DESIRED_SIZE       = 2
  MAX_SIZE           = 2
  MIN_SIZE           = 2
  CREATE_ALB_INGRESS = true
}

provider "aws" {
  region = "us-east-1"
}
