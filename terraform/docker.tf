locals {
  tag = "1.0"
}

resource "docker_image" "image" {
  name = format("%v:%v", aws_ecr_repository.new_repo.repository_url, local.tag)
  build {
    context    = "${path.cwd}/../lambda"
    dockerfile = "lambda.Dockerfile"
  }
}

resource "docker_image_registry" "image_registry" {
  name = docker_image.image.name
}
