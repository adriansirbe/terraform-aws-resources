terraform {
  backend "s3" {
    encrypt = true
    bucket  = "terraform-aws-resources-state-s3"
    region  = "eu-central-1"
    key     = "terraform.tfstate"
  }
}

module "s3" {
  source = "./s3"
}

module "vpc" {
  source                        = "./vpc"
  eu-central-1a-infra-subnet-id = "${module.subnet.eu-central-1a-infra-subnet-id}"
}

module "subnet" {
  source       = "./subnet"
  infra-vpc-id = "${module.vpc.vpc-id}"
}

module "sg" {
  source       = "./sg"
  infra-vpc-id = "${module.vpc.vpc-id}"
}

module "ec2" {
  source                        = "./ec2"
  infra-vpc-id                  = "${module.vpc.vpc-id}"
  eu-central-1a-infra-subnet-id = "${module.subnet.eu-central-1a-infra-subnet-id}"
  jenkins-sg-id                 = "${module.sg.jenkins-sg-id}"
}
