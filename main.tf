#data "terraform_remote_state" "infra" {
#  backend = "s3"
#  config = {
#    bucket = "my-terraform-state-bucket"
#    key    = "path/to/project/terraform.tfstate"
#    region = "eu-west-1"
#  }
#}

provider "aws" {
  region = "eu-west-1"
}

## Ahora puedes acceder al bucket S3 del otro proyecto
#resource "aws_s3_bucket_object" "dags" {
#  for_each = fileset("${path.module}/dags", "*.py")

#  bucket = data.terraform_remote_state.infra.outputs.mwaa_bucket_name
#  key    = "dags/${each.value}"
#  source = "${path.module}/dags/${each.value}"
#}

resource "aws_s3_object" "dags" {
  for_each = fileset("${path.module}/dags", "*.py")

  bucket = var.mwaa_bucket_name
  key    = "dags/${each.value}"
  source = "${path.module}/dags/${each.value}"
  acl    = "private"  # Puedes ajustar el ACL según lo necesites, ej: "bucket-owner-full-control"
}
