resource "aws_s3_bucket" "basic-web-application-2020" {
  bucket = "basic-web-application-2020"

  versioning {
        enabled = true
    }

  tags = {
    Name        = "basic-web-application-2020"
  }
}