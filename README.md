# DATA ENGINEERING PROJECT

## TITLE: "Building an Efficient NYC Taxi Trip Batch Data Pipeline for Analytical Insights"

## Introduction

welcome to my first Data Engineering project, the aim of this project is to build an efficient data pipeline for effective data management and better data-driven suggestions.
this projects invloves ETL and ELT operations it is also a major step for me in showing my understanding of how big data tools work and how to connect them to build an efficient data pipeline.

## Architecture

### This projects involves ETL and ELT operations.
**ELT Operations:** Data is extracted from nyc trip website, loaded to a postgresql database and transformed using DBT.  
**ETL Operations:** the Transformed DBT data is extracted from the postgresql database using pyspark, the data is transformed and then loaded to a postgresql database for virtualization, this process involves reducing the rows from over 18 million rows to 2000 plus rows by aggregation.  
**Data Storage:** Transformed DBT data is stored in an AWS S3 bucket using pyspark and boto3.

### Technologies

Docker for containerization  
Apache Airflow for Orchestration  
Terrafrom for Infrastructure as a code(IaaC)  
Postgresql for Database and Data warehousing  
DBT local for data transoformation and batch processing  
Pyspark for batch processing and data transformation  
looker stuido for dashboard virtualization  
Amazon S3 as Data lake  
boto3 for batch procesing  
python for scripting.  

### Dashboard




