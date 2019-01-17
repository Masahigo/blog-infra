# blog-infra
Infra scripts for the blog.

Initial files for the `project_creation` are [from here](https://github.com/GoogleCloudPlatform/deploymentmanager-samples/tree/master/examples/v2/project_creation). I modified them into a template so that some of the parameters can be passed in. My main goal was to automate the creation of projects as far as possible and learn to use Deployment Manager in general. I also wanted everything to be executed from Cloud Build and this required some additional IAM permissions described in the updated [README](https://github.com/Masahigo/blog-infra/blob/master/project_creation/README.md#enabling-cloud-build).

**CLI calls used**

Initial provisioning for the GCP project to host the blog:

```bash
gcloud config set project dm-creation-project-xxxxxx
gcloud builds submit --config ./project_creation/cloudbuild.yaml ./project_creation
```

Creating managed zone to the newly created project:

```bash
gcloud config set project ms-devops-dude
gcloud builds submit --config ./dns/cloudbuild.yaml ./dns
```

Custom build step for running Hexo commands:

```bash
gcloud config set project ms-devops-dude
gcloud builds submit --config=./hexo-build-step/cloudbuild.yaml ./hexo-build-step/ --project=ms-devops-dude
```