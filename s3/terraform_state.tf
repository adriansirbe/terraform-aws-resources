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

    server_side_encryption_configuration {
      rule {
        apply_server_side_encryption_by_default {
          sse_algorithm = "AES256"
        }
      }
    }

    tags = {
        Name = "S3 terraform state store"
    }
}
