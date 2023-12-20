#!/bin/bash
## 
## Workflow to populate the variables

VAR_LIST=("Company Name" "Company Two")

if [ ! -d .github/ISSUE_TEMPLATE/ ]; then mkdir -p .github/ISSUE_TEMPLATE; fi

cat << EOF > .github/ISSUE_TEMPLATE/setup_new_company.yml

name: Setup New Company
description: initial setup
title: "[Setup New]"
labels: ["init"]
assignees:
  - pknw1
body:
EOF

for ((i = 0; i < ${#VAR_LIST[@]}; i++))
  do
    VARNAME=$(echo "${VAR_LIST[$i]}"| sed 's/\ /_/g' | tr [:lower:] [:upper:])
    cat << EOF >> .github/ISSUE_TEMPLATE/setup_new_company.yml
  - type: input
    attributes:
      label: "${VARNAME}"
      placeholder: "Enter Your Value Here"

EOF
done

cat << EOF >> .github/ISSUE_TEMPLATE/setup_new_company.yml
  - type: checkboxes
    id: common
    attributes:
      label: Final Checks
      description: Check [HERE](https://www.pknw1.co.uk/common_issues) incase there is a simple fix
      options:
        - label: Description and Steps to Reproduce complete (except for Query Support)
          required: false
        - label: I have completed basic checks for my issue and verified with other users 
          required: false
EOF

if [ ! -d .github/workflows ]; then mkdir -p .github/workflows; fi
cp src/init_wf .github/workflows/setup.yml

#mv .github/workflows/init.yml .github/workflows/init
