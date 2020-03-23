variable "secret_string" {
  type        = string
  description = "Secret String for AWS Secrets Manager"
}

variable "secret_key_base" {
  type        = string
  description = "Secret Key base for Mind The Gapp Pheonix Application"
}

variable "cors_allowed_endpoint" {
  type = string
  description ="Cors allowed endpoint"
}

variable "ebs_app" {
   type = string
   description = "AWS Elastic Beanstalk Application Name"
}

variable "ebs_env" {
   type = string
   description = "AWS Elastic Beanstalk Environment Name"
}

variable "s3_bucket" {
   type = string
   description = "AWS S3 Bucket Name"
}

variable "db_name" {
   type = string
   description = "RDS DB Name"
}

variable "secretsmanager" {
   type = string
   description = "AWS Secretsmanager secret name"
}
