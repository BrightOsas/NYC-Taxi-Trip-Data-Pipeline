# DATA ENGINEERING PROJECT

## *TITLE*: Building an Efficient Batch Data Pipeline for Analytical Insights

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



## Dashboard
**Data Description:** Dataset contains data for the year 2023, it provides insight on the Taxi trips record for the 6 boroughs in New York City with respect to taxi vendors, service type and trip record type.   
  
[Link To Dashboard](https://lookerstudio.google.com/u/0/reporting/63cb0bd5-82ce-4a18-85ef-43337b92e331/page/p_8bkuzl286c)

    
![NEW](https://github.com/BrightOsas/NYC-Taxi-Trip-Data-Pipeline/assets/98474404/e6fc4fb5-df98-45af-a950-6256e45e28d7)



![db3](https://github.com/BrightOsas/NYC-Taxi-Trip-Data-Pipeline/assets/98474404/ccbf2b99-045a-4cdb-8c58-8c47daba0823)
  
  
  
## Technologies

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


## How to run the Project
clone this repository  
set up the environment and requiremnt
* cd data-ingestion folder : docker compose up -d --build
* cd airflow orchestration folder : docker compose up -d --build
* setup dbt(local) python env: dbt run
* run pyspark script in jupyter environment.


## contact
* [Bright Osarenren](linkedin.com/in/brightosas)
* [Project link](https://github.com/BrightOsas/NYC-Taxi-Trip-Data-Pipeline)

