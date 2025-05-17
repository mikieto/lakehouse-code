###############################################################################
# Athena workgroup – encrypted query results
###############################################################################

###########################
# 1. KMS key for Athena   #
###########################
resource "aws_kms_key" "athena_cmk" {
  description         = "CMK for Athena result encryption"
  enable_key_rotation = true
}

##################################
# 2. Athena workgroup definition #
##################################
resource "aws_athena_workgroup" "lakehouse" {
  name = "lakehouse_wg"

  configuration {
    enforce_workgroup_configuration = true

    result_configuration {
      output_location = "s3://${aws_s3_bucket.raw.bucket}/athena-results/"

      encryption_configuration {
        encryption_option = "SSE_KMS"
        kms_key_arn       = aws_kms_key.athena_cmk.arn
      }
    }
  }
}

###########
# Outputs #
###########
output "athena_workgroup_name" { value = aws_athena_workgroup.lakehouse.name }
output "athena_results_prefix" {
  value = "s3://${aws_s3_bucket.raw.bucket}/athena-results/"
}
