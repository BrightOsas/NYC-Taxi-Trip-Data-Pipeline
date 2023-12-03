# DATA ENGINEERING PROJECT

## *TITLE*: Building an Efficient NYC Taxi Trip Batch Data Pipeline for Analytical Insights

## Introduction

Welcome to my first Data Engineering project! The objective is to construct an efficient data pipeline for improved data management and more effective data-driven suggestions. This project involves both ETL and ELT operations, showcasing my understanding of how to utilize big data tools to build an efficient data pipeline. 

![r2](https://github.com/BrightOsas/NYC-Taxi-Trip-Data-Pipeline/assets/98474404/e1aae350-88a4-40dc-af0a-ce8d1c517103)
  
  
## Architecture
 
![taxi-architecture drawio](https://github.com/BrightOsas/NYC-Taxi-Trip-Data-Pipeline/assets/98474404/a5f12866-484b-4959-bbb9-8962f11d41df)


### ELT/ETL Operations Overview  
**ELT Operations:**
Data is extracted from the NYC trip website, loaded into a PostgreSQL database, and transformed using DBT. 

**ETL Operations:**
The transformed DBT data is extracted from the PostgreSQL database using PySpark, undergoes further transformation, and is then loaded into another PostgreSQL database for virtualization. This process includes aggregating the data to reduce the number of rows from over 18 million to 2000-plus.

**Data Storage:**
Transformed DBT data is stored in an AWS S3 bucket using PySpark and Boto3.

### Technologies

* Docker: Containerization  
* Apache Airflow: Orchestration   
* Terraform: Infrastructure as Code (IaaC)  
* PostgreSQL: Database and Data Warehousing  
* DBT (Data Build Tool) Local: Data Transformation and Batch Processing  
* PySpark: Batch Processing and Data Transformation  
* Looker Studio: Dashboard Virtualization 
* Amazon S3: Data Lake  
* Boto3: Batch Processing  
* Python: Scripting  

### Dashboard
**Data Description:** Dataset contains data for the year 2023, it provides insight on the Taxi trips record for the 6 boroughs in New York City with respect to taxi vendors, service type and trip record type.  
![db11](https://github.com/BrightOsas/NYC-Taxi-Trip-Data-Pipeline/assets/98474404/0e526bbd-88a7-4570-9ea7-6d3981417c50)
![db3](https://github.com/BrightOsas/NYC-Taxi-Trip-Data-Pipeline/assets/98474404/ccbf2b99-045a-4cdb-8c58-8c47daba0823)


## contact
* [Bright Osarenren](linkedin.com/in/brightosas)
* [Project link](https://github.com/BrightOsas/NYC-Taxi-Trip-Data-Pipeline)

