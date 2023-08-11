resource "aws_s3_bucket" "bucket" {
  bucket = "${var.env_name}-data52"
}
/* 
  AWS recommends using policies instead of ACLs when possible and has
  recently changed the S3 bucket settings to disable ACLs by default
*/
