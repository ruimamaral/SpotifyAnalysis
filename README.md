# SpotifyAnalysis
ETL pipeline for Spotify API data.

This pipeline extracts data from the Spotify API and uploads it to a datalake. I'm currently extracting song data from Spotify's Rap Caviar playlist which updates weekly.

Terraform was used in order to manage all of the infrastructure resources.

An AWS EventBridge rule triggers a lambda function weekly, which runs a containerized (Docker) python script that pulls data from the Spotify API and loads it into an S3 bucket.

Terraform creates all the needed Cloud resources for the pipeline to run and also builds and pushes the container image to AWS ECR.


### How to setup

* Install terraform and docker

* Fill in the [terraform.tfvars](terraform/terraform.tfvars) file's variables with your spotify API and AWS user credentials as well as your preferred AWS region (default is eu-west-3)

* Fill in your Terraform Cloud organization name and workspace in the [backend.tf](terraform/backend.tf) file **OR** remove the `cloud` block altogether in order not to use Terraform Cloud (local backend)

* Run `terraform init` followed by `terraform apply` inside the [terraform](terraform) directory

That's it.