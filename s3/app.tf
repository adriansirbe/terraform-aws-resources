resource "aws_s3_bucket" "basic-web-application-2020" {
  bucket = "basic-web-application-2020"

  versioning {
        enabled = true
    }

  tags = {
    Name        = "basic-web-application-2020"
  }
}

resource "aws_cloudfront_distribution" "basic_web_application" {
  origin {
    domain_name = "${aws_s3_bucket.basic-web-application-2020.bucket_regional_domain_name}"
    origin_id   = "s3-basic-web-application-2020-bucket"

    custom_origin_config {
      http_port = 80
      https_port = 443
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

    enabled             = true
    default_root_object = "index.html"
    wait_for_deployment = false

    custom_error_response {
      error_caching_min_ttl = 0
      error_code = 404
      response_code = 200
      response_page_path = "/index.html"
    }

    default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-basic-web-application-2020-bucket"

    forwarded_values {
      query_string = true
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}