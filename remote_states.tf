##########################
# Realm VPC Remote State #
##########################
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config {
    bucket = "sm.terraform-state.${var.realm}.${var.aws_region}"
    key = "infrastructure-core/vpc/terraform.tfstate"
    region = "${var.aws_region}"
  }
}

provider "aws" {
  region               = "${var.aws_region}"
  allowed_account_ids  = ["${data.terraform_remote_state.vpc.aws_account_id}"]
}
