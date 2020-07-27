#!/bin/bash

echo "TRAVIS_BRANCH=$TRAVIS_BRANCH"
echo "TRAVIS_PULL_REQUEST=$TRAVIS_PULL_REQUEST"
echo "TRAVIS_BUILD_DIR=$TRAVIS_BUILD_DIR"

cd $TRAVIS_BUILD_DIR
echo "validating db.json"  && packer validate -var-file packer/variables.json packer/db.json
echo "validating app.json" && packer validate -var-file packer/variables.json packer/app.json

cd $TRAVIS_BUILD_DIR/terraform/stage
terraform init && terraform validate && tflint --module --var-file terraform.tfvars.example

cd $TRAVIS_BUILD_DIR/terraform/prod
terraform init && terraform validate && tflint --module --var-file terraform.tfvars.example

cd $TRAVIS_BUILD_DIR/ansible/playbooks
# > /dev/null
for playbook in ./*.yml; do
    ansible-lint -v --exclude=roles/jdauphant.nginx $playbook
done
#cd - > /dev/null
