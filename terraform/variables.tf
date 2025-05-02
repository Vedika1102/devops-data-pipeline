variable "aws_region" {
    description = "AWS region to deploy resources"
    default = "us-east-1"
}

variable "project_name" {
    default = "dml-temperature-analysis"
    description = "The project name"

}
variable "use_existing_bucket" {
  description = "Set to true to use an existing S3 bucket instead of creating a new one"
  type        = bool
  default     = false
}


variable "existing_bucket_name" {
    description = "The name of the s3 bucket name"
    type = string
    default = "dml-temperature-analysis-raw-data"
}
