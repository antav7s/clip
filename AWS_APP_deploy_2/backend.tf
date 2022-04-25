/* #Backup of state file written to terraform.tfstate.backup on S3 bucket.
terraform {
  backend "s3" {
    bucket = "terra-state-riguerre"
    key    = "terraform/backup_main"
    region = "us-west-2"
  }
}*/