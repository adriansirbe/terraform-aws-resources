# terraform {
#     backend "s3" {
#         encrypt = true
#         bucket  = "terraform-aws-resources-state-s3"
#         region  = "eu-central-1"
#         key     = "terraform.tfstate"
#     }
# }