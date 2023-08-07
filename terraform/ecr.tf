resource "aws_ecr_repository" "new_repo" {
  name = "${var.env_name}_repository"
}
