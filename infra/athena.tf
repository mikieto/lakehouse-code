# ---------- athena.tf ----------
resource "aws_athena_workgroup" "lakehouse" {
  name = "${var.prefix}_wg"

  configuration {
    result_configuration {
      output_location = "s3://${aws_s3_bucket.raw.bucket}/athena/"
    }
  }
}

output "athena_workgroup" {
  value = aws_athena_workgroup.lakehouse.name
}
