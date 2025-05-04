#!/bin/bash

# Set project and AWS account details
PROJECT_NAME="dml-temperature-analysis"
AWS_ACCOUNT_ID="560456617555"
REGION="us-east-1"

check_resource_in_state() {
  terraform state list | grep "$1" > /dev/null 2>&1
}

echo "⚙️  Starting Terraform state import..."

# S3 Bucket
echo "📦 Importing S3 bucket..."
if aws s3api head-bucket --bucket "${PROJECT_NAME}-raw-data" 2>/dev/null; then
  if ! check_resource_in_state "aws_s3_bucket.raw_data"; then
    terraform import aws_s3_bucket.raw_data "${PROJECT_NAME}-raw-data"
  else
    echo "✅ S3 bucket already in Terraform state"
  fi
else
  echo "❌ S3 bucket does not exist"
fi

# Glue Catalog Database
echo "📚 Importing Glue Catalog Database..."
if aws glue get-database --catalog-id "$AWS_ACCOUNT_ID" --name "${PROJECT_NAME}_catalog" --region $REGION 2>/dev/null; then
  if ! check_resource_in_state "aws_glue_catalog_database.main"; then
    terraform import aws_glue_catalog_database.main "${PROJECT_NAME}_catalog"
  else
    echo "✅ Glue catalog database already in Terraform state"
  fi
else
  echo "❌ Glue database does not exist"
fi

# Glue Crawler
echo "🕷️  Importing Glue Crawler..."
if aws glue get-crawler --name "${PROJECT_NAME}-crawler" --region $REGION 2>/dev/null; then
  if ! check_resource_in_state "aws_glue_crawler.main"; then
    terraform import aws_glue_crawler.main "${PROJECT_NAME}-crawler"
  else
    echo "✅ Glue crawler already in Terraform state"
  fi
else
  echo "❌ Glue crawler does not exist"
fi

# IAM Role
echo "🔐 Importing IAM Role..."
if aws iam get-role --role-name "AWSGlueServiceRole-${PROJECT_NAME}-v2" 2>/dev/null; then
  if ! check_resource_in_state "aws_iam_role.glue_role"; then
    terraform import aws_iam_role.glue_role "AWSGlueServiceRole-${PROJECT_NAME}-v2"
  else
    echo "✅ IAM role already in Terraform state"
  fi
else
  echo "❌ IAM role does not exist"
fi

echo "✅ Done syncing Terraform state!"
