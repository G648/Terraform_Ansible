terraform {
  backend "s3"{
      bucket = "learning-terraform-amorim"
      key = "terraform.tfstate"
      region = "us-east-1"
  }
}