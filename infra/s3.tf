# infra/s3.tf
###############################################################################
# S3 – two data buckets: “raw” landing zone and Iceberg table storage
# Includes:
#   • customer-managed KMS encryption
#   • public-access blocks
#   • versioning
#   • server-access logging
#   • life-cycle transition (Iceberg snapshots → Glacier after 30 days)
###############################################################################

###########################
# 0. Shared KMS key (CMK) #
###########################
resource "aws_kms_key" "s3_cmk" {
  description         = "CMK for raw/iceberg buckets"
  enable_key_rotation = true
}

###################################
# 1. Access-log bucket (target)   #
###################################
resource "aws_s3_bucket" "logs" {
  bucket        = "${local.full_prefix}-logs"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "logs" {
  bucket                  = aws_s3_bucket.logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.s3_cmk.arn
    }
  }
}

###################################
# 2. Raw landing-zone bucket      #
###################################
resource "aws_s3_bucket" "raw" {
  bucket        = "${local.full_prefix}-raw"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "raw" {
  bucket                  = aws_s3_bucket.raw.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "raw" {
  bucket = aws_s3_bucket.raw.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.s3_cmk.arn
    }
  }
}

resource "aws_s3_bucket_versioning" "raw" {
  bucket = aws_s3_bucket.raw.id
  versioning_configuration { status = "Enabled" }
}

resource "aws_s3_bucket_logging" "raw" {
  bucket        = aws_s3_bucket.raw.id
  target_bucket = aws_s3_bucket.logs.id
  target_prefix = "raw/"
}

###################################
# 3. Iceberg table-storage bucket #
###################################
resource "aws_s3_bucket" "iceberg" {
  bucket        = "${local.full_prefix}-iceberg"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "iceberg" {
  bucket                  = aws_s3_bucket.iceberg.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "iceberg" {
  bucket = aws_s3_bucket.iceberg.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.s3_cmk.arn
    }
  }
}

resource "aws_s3_bucket_versioning" "iceberg" {
  bucket = aws_s3_bucket.iceberg.id
  versioning_configuration { status = "Enabled" }
}

resource "aws_s3_bucket_logging" "iceberg" {
  bucket        = aws_s3_bucket.iceberg.id
  target_bucket = aws_s3_bucket.logs.id
  target_prefix = "iceberg/"
}

# Life-cycle: move old Iceberg snapshots to Glacier after 30 days
resource "aws_s3_bucket_lifecycle_configuration" "iceberg" {
  bucket = aws_s3_bucket.iceberg.id

  rule {
    id     = "expire-snapshots"
    status = "Enabled"

    filter { prefix = "" }

    transition {
      days          = 30
      storage_class = "GLACIER"
    }
  }
}

###################
# 4. Outputs      #
###################
output "raw_bucket" { value = aws_s3_bucket.raw.bucket }
output "iceberg_bucket" { value = aws_s3_bucket.iceberg.bucket }
output "logs_bucket" { value = aws_s3_bucket.logs.bucket }
