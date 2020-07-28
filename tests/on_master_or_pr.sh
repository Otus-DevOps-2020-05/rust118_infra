#!/bin/bash

HOMEWORK=Otus-DevOps-2020-05/rust118_infra

cd $HOMEWORK
pwd

if [ "$TRAVIS_EVENT_TYPE" == "pull_request" ] || ( [ "$TRAVIS_EVENT_TYPE" == "push" ] && [ "$TRAVIS_BRANCH" == "master" ] )
then
    pwd

    echo "validating db.json"  && packer validate -var-file $HOMEWORK/packer/variables.json packer/db.json
    echo "validating app.json" && packer validate -var-file $HOMEWORK/packer/variables.json packer/app.json

    cd $HOMEWORK/terraform/stage
    terraform init && terraform validate && tflint --module --var-file terraform.tfvars.example

    cd $HOMEWORK/terraform/prod
    terraform init && terraform validate && tflint --module --var-file terraform.tfvars.example

    cd $HOMEWORK/ansible/playbooks
    for playbook in ./*.yml; do
        ansible-lint -v --exclude=roles/jdauphant.nginx $playbook
    done
fi