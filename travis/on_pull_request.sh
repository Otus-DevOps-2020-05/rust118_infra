#!/bin/bash

WDIR=$(pwd)
echo $WDIR

packer validate -var-file packer/variables.json packer/db.json
packer validate -var-file packer/variables.json packer/app.json

cd terraform/stage && terraform validate && tflint --module --var-file terraform.tfvars.example; cd -
cd terraform/prod  && terraform validate && tflint --module --var-file terraform.tfvars.example; cd -

cd ansible/playbooks
for playbook in ./*.yml; do
    ansible-lint $playbook
done
cd -

# README.md добавлен бейдж с статусом билда

cd $WDIR
