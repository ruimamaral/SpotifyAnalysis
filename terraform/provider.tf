provider "aws" {
  region = var.region
}

provider "docker" {
  registry_auth {
    address  = aws_ecr_repository.new_repo.url
    username = data.aws_ecr_authorization_token.token.user_name
    password = data.aws_ecr_authorization_token.token.password
  }
}
