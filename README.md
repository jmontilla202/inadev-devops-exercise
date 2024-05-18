<div style=text-align: center>## Wapi App</div>

## Wapi App - Weather API

### How to deploy cluster and Jenkins:

- clone this repo
- cd into <repo folder>/terraform folder
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
- EKS cluster
- Jenkins deployment
- Wapi App Deployment

### How to build app locally:

- clone this repo
- cd into <repo folder>/src
- go get github.com/gin-gonic/gin
- go build



