provider "aws" {
  region = ""

}

resource "aws_s3_bucket" "taxis3bucket" {
  bucket = "brighttaxitrips3bucket"

}