provider "aws" {
    region = "eu-central-1"
}

resource "aws_s3_bucket" "terraform-aws-resources-state-s3" {
    bucket = "terraform-aws-resources-state-s3"

    versioning {
        enabled = true
    }

    lifecycle {
        prevent_destroy = true
    }

    tags = {
        Name = "S3 terraform state store"
    }
}

# resource "aws_s3_bucket" "testing-aws-resources" {
#     bucket = "testing-aws-resources"


#     tags = {
#         Name = "testing bucket"
#     }
# }

