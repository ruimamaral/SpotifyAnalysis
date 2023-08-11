provider "aws" {
  region = var.region
}

provider "docker" {
  registry_auth {
    address  = "${data.aws_caller_identity.this.account_id}.dkr.ecr.${var.region}.amazonaws.com"
    username = data.aws_ecr_authorization_token.token.user_name
    password = data.aws_ecr_authorization_token.token.password
  }
}
