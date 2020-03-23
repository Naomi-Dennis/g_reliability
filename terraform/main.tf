resource "aws_elastic_beanstalk_application" "mind_the_gapp" {
  name = var.ebs_app
}

resource "aws_elastic_beanstalk_application_version" "mind_the_gapp" {
  name        = "mind_the_gapp_app_version"
  application = aws_elastic_beanstalk_application.mind_the_gapp.name
  description = "application version created by terraform"
  bucket      = aws_s3_bucket.mind_the_gapp.id
  key         = aws_s3_bucket_object.project.id
}

resource "aws_elastic_beanstalk_configuration_template" "mind_the_gapp" {
  name                = "mind-the-gapp-prod-config-v1"
  application         = aws_elastic_beanstalk_application.mind_the_gapp.name
  solution_stack_name = aws_elastic_beanstalk_environment.mind_the_gapp.solution_stack_name
  environment_id      = aws_elastic_beanstalk_environment.mind_the_gapp.id
}

resource "aws_s3_bucket" "mind_the_gapp" {
  bucket = var.s3_bucket
}

resource "aws_s3_bucket_object" "project" {
  bucket = aws_s3_bucket.mind_the_gapp.id
  key    = "terraform.tfstate"
  source = "./terraform.tfstate"
}

resource "aws_elastic_beanstalk_environment" "mind_the_gapp" {
  name                = var.ebs_env
  application         = aws_elastic_beanstalk_application.mind_the_gapp.name
  solution_stack_name = "64bit Amazon Linux 2018.03 v2.14.2 running Docker 18.09.9-ce"

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "GAPP_DB"
    value     = aws_db_instance.db.address
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "GAPP_PASS"
    value     = aws_secretsmanager_secret_version.db_pass.secret_string
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "SECRET_KEY_BASE"
    value     = var.secret_key_base
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "CORS_ALLOWED_ENDPOINT"
    value     = var.cors_allowed_endpoint
  }

}

resource "aws_secretsmanager_secret" "db_pass" {
  name = var.secretsmanager
}

resource "aws_secretsmanager_secret_version" "db_pass" {
  secret_id     = aws_secretsmanager_secret.db_pass.id
  secret_string = var.secret_string
}

resource "aws_db_instance" "db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "11.6"
  instance_class       = "db.t3.micro"
  name                 = var.db_name
  username             = "postgres"
  password             = aws_secretsmanager_secret_version.db_pass.secret_string
  parameter_group_name = "psql11"
  publicly_accessible  = "true"
}
