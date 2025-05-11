# s3.tf - two buckets: raw landing & Iceberg tables
resource "aws_s3_bucket" "raw" {
  bucket        = "${var.prefix}-raw"
  force_destroy = true
}

resource "aws_s3_bucket" "iceberg" {
  bucket        = "${var.prefix}-iceberg"
  force_destroy = true
}

resource "aws_s3_bucket_lifecycle_configuration" "iceberg" {
  bucket = aws_s3_bucket.iceberg.id

  rule {
    id     = "expire-snapshots"
    status = "Enabled"

    filter {
      prefix = ""
    }

    transition {
      days          = 30
      storage_class = "GLACIER"
    }
  }
}

output "raw_bucket" { value = aws_s3_bucket.raw.bucket }
output "iceberg_bucket" { value = aws_s3_bucket.iceberg.bucket }
