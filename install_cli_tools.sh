#!/bin/bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip -d ./aws_local
sudo ./aws_local/aws/install -b ./aws_cmd
export tf_version=0.12.20 tf_init_cli_options="-input=false" tf_validation_cli_options="" tf_plan_cli_options="-lock=false -input=false" tf_apply_cli_options="-auto-approve -input=false"
wget https://releases.hashicorp.com/terraform/"$tf_version"/terraform_"$tf_version"_linux_amd64.zip
sudo unzip terraform_"$tf_version"_linux_amd64.zip -d ./terraform_cmd