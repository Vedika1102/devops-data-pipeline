output "raw_bucket_name" {
    description = "Name of raw data s3 bucket"
    value = aws_s3_bucket.raw_data.id
}

output "bucket_name" {
    description = "Name of S3 bucket"
    value = aws_s3_bucket.raw_data.id
}