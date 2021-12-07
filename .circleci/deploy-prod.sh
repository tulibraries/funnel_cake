#!/bin/bash
set -e

cd ..
# clone deployment playbook
git clone --single-branch --branch main git@github.com:tulibraries/ansible-playbook-funcake.git funcake-prod
cd funcake-prod
# install playbook requirements
pipenv install
# install playbook role requirements
pipenv run ansible-galaxy install -r requirements.yml
# setup vault password retrieval from travis envvar
cp .circleci/.vault ~/.vault
# setup vault password retrieval from travis envvar
chmod +x ~/.vault

# deploy to qa using ansible-playbook
pipenv run ansible-playbook -i inventory/prod/hosts playbook.yml --vault-password-file=~/.vault --private-key=~/.ssh/.conan_the_deployer --extra-vars 'rails_app_git_branch=$CIRCLE_TAG'
