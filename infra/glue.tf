# glue.tf - minimal metadata layer ─ one Glue DB + demo table
resource "aws_glue_catalog_database" "demo" {
  name = "${local.full_prefix}_db"
}

resource "aws_glue_catalog_table" "customers" {
  name          = "customers"
  database_name = aws_glue_catalog_database.demo.name
  table_type    = "EXTERNAL_TABLE"

  parameters = {
    classification = "iceberg"
    table_type     = "iceberg"
    format         = "parquet"
  }

  storage_descriptor {
    location      = "s3://${aws_s3_bucket.iceberg.bucket}/customers/"
    input_format  = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat"

    ser_de_info {
      serialization_library = "org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe"
    }

    columns {
      name = "id"
      type = "int"
    }
    columns {
      name = "name"
      type = "string"
    }

  }
}
