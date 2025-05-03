#!/bin/bash

# Set your project name and AWS account ID
PROJECT_NAME="dml-temperature-analysis"
AWS_ACCOUNT_ID="560456617555"

# Function to check if resource is already in Terraform state
check_resource_in_state() {
  terraform state list | grep "$1" > /dev/null 2>&1
}

# Import Glue Catalog Database
echo "Importing Glue catalog database..."

if aws glue get-database --catalog-id "$AWS_ACCOUNT_ID" --name "${PROJECT_NAME}_catalog" > /dev/null 2>&1; then
  if ! check_resource_in_state "aws_glue_catalog_database.main"; then
    terraform import aws_glue_catalog_database.main "${PROJECT_NAME}_catalog"
  else
    echo "Glue catalog database already in state"
  fi
else
  echo "Glue database ${PROJECT_NAME}_catalog does not exist"
fi

# Import Glue Crawler
echo "Importing Glue crawler..."

if aws glue get-crawler --name "${PROJECT_NAME}-crawler" > /dev/null 2>&1; then
  if ! check_resource_in_state "aws_glue_crawler.main"; then
    terraform import aws_glue_crawler.main "${PROJECT_NAME}-crawler"
  else
    echo "Glue crawler already in state"
  fi
else
  echo "Glue crawler ${PROJECT_NAME}-crawler does not exist"
fi
