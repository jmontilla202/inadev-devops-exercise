### Completed:
- Cluster deployment automated
- Jenkins deployment to cluster automated 
- App builds ok, functional locally
- App builds in Jenkins using Dockerfile and from the command line

### How to deploy cluster and Jenkins:
- cd into terraform folder
- terraform init
- terraform plan
- terraform apply

### How to build app:
- cd into wtw/src
- go get github.com/gin-gonic/gin
- go build

### Pending:
- Jenkins configuration automation (plugins, tools and credentials)
- Expose Jenkins and app (can access Jenkins via port forwarding)
- Github / Jenkins webhook to build / deploy app
- Soup to nuts script (bash, python or ansible)
