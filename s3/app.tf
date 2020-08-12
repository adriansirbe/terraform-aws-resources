resource "aws_s3_bucket" "web-nodejs-app" {
  bucket = "web-nodejs-app"

  versioning {
        enabled = true
    }

  tags = {
    Name        = "web-nodejs-app"
  }
}