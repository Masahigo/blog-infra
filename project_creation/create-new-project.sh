export GCP_PROJ_ID=`gcloud info |tr -d '[]' | awk '/project:/ {print $2}'`
export GCP_OWNER_ACCOUNT=`gcloud projects get-iam-policy $GCP_PROJ_ID --flatten='bindings[].members' --format='value(bindings.members)' --filter='bindings.role:roles/owner'`
export GCP_BILLING_ACCOUNT_ID=`gcloud beta billing accounts list --filter "My Billing Account" --format='value(ACCOUNT_ID)'`
export GCP_ORG_ID=`gcloud organizations list --filter "msdevopsdude.com" --format='value(ID)'`

gcloud deployment-manager deployments create $GCP_DEPLOYMENT_NAME --template project-creation-template.jinja --properties="organization-id:'$GCP_ORG_ID',billing-account-id:$GCP_BILLING_ACCOUNT_ID,project-name:'$GCP_NEW_PROJECT_NAME',owner-account:'$GCP_OWNER_ACCOUNT'"