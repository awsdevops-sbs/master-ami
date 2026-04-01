terraform {
backend "s3" {

  bucket = "mybucket162977"
  key= "ami/state"
  region = "us-east-1"
}

}