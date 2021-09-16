resource "aws_kms_key" "kmskey" {
  description             = var.bucketkey
  deletion_window_in_days = 10
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket
  acl    = "private"

 #force_destroy = true
 
  versioning {
    enabled = true
  }


  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.kmskey.id
        sse_algorithm     = "aws:kms"
      }
    }
  }

}
