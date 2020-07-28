#!/bin/bash

pwd
HOMEWORK=Otus-DevOps-2020-05/rust118_infra
echo $HOMEWORK

#echo "TRAVIS_EVENT_TYPE=$TRAVIS_EVENT_TYPE"
#echo "TRAVIS_BRANCH=$TRAVIS_BRANCH"
#echo "TRAVIS_PULL_REQUEST=$TRAVIS_PULL_REQUEST"
#echo "TRAVIS_BUILD_DIR=$TRAVIS_BUILD_DIR"

#cd $HOMEWORK

#curl -o p.zip https://releases.hashicorp.com/packer/1.6.0/packer_1.6.0_linux_amd64.zip && unzip -o p.zip
#curl -o tf.zip https://releases.hashicorp.com/terraform/0.12.29/terraform_0.12.29_linux_amd64.zip && unzip -o tf.zip
#curl -L "$(curl -Ls https://api.github.com/repos/terraform-linters/tflint/releases/latest | grep -o -E "https://.+?_linux_amd64.zip")" -o tflint.zip && unzip -o tflint.zip
#pip install --user ansible-lint
#- sudo apt update
#- sudo apt install software-properties-common
#- sudo apt-add-repository --yes --update ppa:ansible/ansible
#- sudo apt install ansible

if [ $TRAVIS_EVENT_TYPE == "pull_request" ] || ( [ $TRAVIS_EVENT_TYPE == "push" ] && [ $TRAVIS_BRANCH == "master" ] ) then

    echo "validating db.json"  && packer validate -var-file $HOMEWORK/packer/variables.json packer/db.json
    echo "validating app.json" && packer validate -var-file $HOMEWORK/packer/variables.json packer/app.json

    cd $HOMEWORK/terraform/stage
    terraform init && terraform validate && tflint --module --var-file terraform.tfvars.example

    cd $HOMEWORK/terraform/prod
    terraform init && terraform validate && tflint --module --var-file terraform.tfvars.example

    cd $HOMEWORK/ansible/playbooks
    # > /dev/null
    for playbook in ./*.yml; do
	ansible-lint -v --exclude=roles/jdauphant.nginx $playbook
    done
    #cd - > /dev/null
fi