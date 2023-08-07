resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.env_name}_data"
}
/* 
  AWS recommends using policies instead of ACLs when possible and has
  recently changed the S3 bucket settings to disable ACLs by default
*/
