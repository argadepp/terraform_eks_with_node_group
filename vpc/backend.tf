terraform {
  backend "s3" {
    bucket = "mystone-project-infra-state-files"
    key = "myvpc_details.tfstates"
    region = "ap-south-1"
  }
}