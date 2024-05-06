# Taskfile.yml
version: '3'

tasks:
  tfi:
    cmds:
      - terraform init
  tfp:
    cmd:
      - terraform plan
  tfa:
    cmd:
      - terraform apply
  tfay:
    cmd:
      - terraform apply -auto-approve
