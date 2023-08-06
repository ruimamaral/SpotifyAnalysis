variable "aws_access_key" {
  description = "Access key for the AWS user"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "Secret key for the AWS user"
  type        = string
  sensitive   = true
}

variable "spotipy_client_id" {
  description = "ID for the spotify API client"
  type        = string
  sensitive   = true
}

variable "spotipy_client_secret" {
  description = "Secret key for the spotify API client"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "AWS region to create resources in"
  type        = string
  default     = "eu-west-3"
}

variable "env_name" {
  description = "Environment name"
  type        = string
}
