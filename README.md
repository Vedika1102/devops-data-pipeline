#  Scalable Data Pipeline on AWS using Terraform & Python

This project is a **production-ready data engineering pipeline** that demonstrates automated ingestion, cataloging, and querying of structured data using **AWS Glue, S3, Athena**, and **Terraform**. It’s built to reflect **real-world patterns in building cloud-native analytics pipelines** that are modular, scalable, and infrastructure-as-code driven.

The current implementation simulates **temperature sensor readings**, but the architecture is extensible to support any form of structured data, from **IoT telemetry and stock prices to app usage logs and transactional records**.

---

## Tech Stack & Skills

| Skill Category         | Tools & Concepts Applied                                                                 |
|------------------------|-------------------------------------------------------------------------------------------|
| **Data Engineering**   | Synthetic data generation, schema design, timestamp handling, quality validation         |
| **Cloud Engineering**  | AWS S3 (data lake), AWS Glue (cataloging), AWS Athena (serverless querying)              |
| **IaC / DevOps**       | Terraform (modular infra), GitHub Actions (CI/CD), IAM roles, policy-based access        |
| **Testing & CI**       | Pytest (unit tests), Bandit (security scans), GitHub workflows for pipeline automation   |

---

##  What This Pipeline Does

### 1. **Data Generation**
- Generates timestamped CSV data simulating real-world temperature sensors.
- Fields: `city`, `temperature`, `timestamp`  customizable for other domains (e.g., CPU usage, retail sales).
- Handles multiple data sizes to simulate batch loads.

### 2. **Data Lake Ingestion**
- Uploads data to **Amazon S3** using Terraform.
- Buckets are versioned and access-controlled via IAM roles.

### 3. **Metadata Cataloging with AWS Glue**
- Automated schema discovery using **AWS Glue Crawlers**.
- Data types (string, double, timestamp) inferred and registered in AWS Glue Data Catalog.

### 4. **Querying with Amazon Athena**
- Enables ad-hoc SQL querying on CSV data directly in S3.
- Supports analytical queries like aggregations, filtering, and joins.
- Athena queries defined in notebooks or UI.

### 5. **CI/CD Pipeline**
- GitHub Actions automates:
  - Data test execution (`pytest`)
  - Code linting & security scans (`bandit`)
  - Infrastructure validation (`terraform plan`)
  - Deployment (`terraform apply`)

---

##  Why This Project Matters

This project encapsulates **end-to-end automation** of a cloud data pipeline from ingestion to query all version-controlled and production-deployable. It reflects the **skillset of a data engineer or cloud engineer** working in **modern analytics teams**, including:

- Infrastructure as Code (Terraform modules)
- Serverless data lake querying (Athena)
- Schema evolution & data governance (Glue)
- CI-driven reproducibility (GitHub Actions)
- Data integrity & test-driven ingestion

---
