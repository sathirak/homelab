#!/bin/bash

set -a
source .env
set +a

export TF_VAR_do_token="$DO_TOKEN"
export TF_VAR_pvt_key="$VAR_PVT_KEY"

cd terraform

terraform init

terraform plan -out=infra.out

terraform apply "infra.out"
