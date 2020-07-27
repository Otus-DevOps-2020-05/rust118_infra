#!/bin/bash

echo "validating db.json"  && packer validate -var-file packer/variables.json packer/db.json
echo "validating app.json" && packer validate -var-file packer/variables.json packer/app.json

echo "validating terraform/stage" && cd terraform/stage > /dev/null
terraform validate && tflint --module --var-file terraform.tfvars.example; cd - > /dev/null
echo "validating terraform/prod" && cd terraform/prod > /dev/null
terraform validate && tflint --module --var-file terraform.tfvars.example; cd - > /dev/null

cd ansible/playbooks > /dev/null
for playbook in ./*.yml; do
    ansible-lint -v --exclude=roles/jdauphant.nginx $playbook
done
cd - > /dev/null
