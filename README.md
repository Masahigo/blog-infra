# blog-infra
Infra scripts for the blog.

Initial files for the `project_creation` are [from here](https://github.com/GoogleCloudPlatform/deploymentmanager-samples/tree/master/examples/v2/project_creation). I modified them into a template so that some of the parameters can be passed in. My main goal was to automate the creation of projects as far as possible and learn to use Deployment Manager in general. I also wanted everything to be executed from Cloud Build and this required some additional IAM permissions described in the updated [README](https://github.com/Masahigo/blog-infra/blob/master/project_creation/README.md#enabling-cloud-build).

**CLI calls used**

Initial provisioning for the GCP projects to host the blog:

```bash
gcloud config set project dm-creation-project-xxxxxx
# Test environment
gcloud builds submit --config ./project_creation/cloudbuild.test.yaml ./project_creation
# Production environment
gcloud builds submit --config ./project_creation/cloudbuild.yaml ./project_creation
```

Creating managed zone to the newly created project (only prod):

```bash
gcloud builds submit --config ./dns/cloudbuild.yaml ./dns --project=ms-devops-dude
```

Initialize App Engine to the newly created projects:

```bash
#gcloud builds submit --config ./appengine/cloudbuild.yaml ./appengine --project=ms-devops-dude
# Currently fails with: "ERROR: (gcloud.app.create) PERMISSION_DENIED: The caller does not have permission"
# UPDATE: Only Project Owner can create App Engine project
# See documentation: https://cloud.google.com/appengine/docs/standard/python/console/#create
gcloud app create --region=europe-west3 --project=ms-devops-dude-test
gcloud app create --region=europe-west3 --project=ms-devops-dude
```

Custom build step for running Hexo commands:

```bash
# Test environment
gcloud builds submit --config=./hexo-build-step/cloudbuild.yaml ./hexo-build-step/ --project=ms-devops-dude-test
# Production environment
gcloud builds submit --config=./hexo-build-step/cloudbuild.yaml ./hexo-build-step/ --project=ms-devops-dude
```