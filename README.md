## Wapi App - Weather API

### How to deploy cluster and Jenkins:

- clone this repo
- cd into **[Repo]**/terraform folder
- terraform init
- terraform plan
- terraform apply (yes to confirm changes)

Proccess can take around 15 minutes to complete.

### Requirement to build environment

- terraform
- aws cli (with admin rights to an AWS account)
- kubectl
- helm
- MacOS or Linux (MacOS should work with little or no modifications)

### Components built / instantiated

- AWS VPC, subnets and releated networking components
- EKS cluster (Nodes: t3a.medium spot x 2)
- Jenkins deployment
- Wapi App Deployment

### Workflow

- Once environment is up build job will get triggered
- Jenkins job will pull down repo, run build , create docker image then push image to registry

### To test app

- Make a GET call to **http://[LoadBalancer IP]/forecast** with either curl or Postman
- json response should be returned, location can be adjusted in main.go

### How to build app locally:

- clone this repo
- cd into **[Repo]**/src
- go get github.com/gin-gonic/gin
- go build

### Screenshots

![image info](https://github.com/jmontilla202/inadev-devops-exercise/blob/main/screenshots/00-terraform_apply.png)
![image info](https://github.com/jmontilla202/inadev-devops-exercise/blob/main/screenshots/01-apply_complete.png)
![image info](https://github.com/jmontilla202/inadev-devops-exercise/blob/main/screenshots/02-jenkins.png)
![image info](https://github.com/jmontilla202/inadev-devops-exercise/blob/main/screenshots/03-resources_deployed.png)
![image info](https://github.com/jmontilla202/inadev-devops-exercise/blob/main/screenshots/04-container_repo.png)
![image info](https://github.com/jmontilla202/inadev-devops-exercise/blob/main/screenshots/05-postman.png)
![image info](https://github.com/jmontilla202/inadev-devops-exercise/blob/main/screenshots/06-curl.png)
![image info](https://github.com/jmontilla202/inadev-devops-exercise/blob/main/screenshots/07-terraform_destroy.png)

## Terraform modules used
- https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
- https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest