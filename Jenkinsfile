pipeline {
      agent {
      kubernetes {
            yaml '''
                apiVersion: v1
                kind: Pod
                metadata:
                labels:
                app: wapi
                version: v0.1
                spec:
                  containers:
                  - name: golang
                    image: golang:1.21.9
                    command:
                    - cat
                    tty: true
                  - name: docker
                    image: docker:latest
                    command:
                    - cat
                    tty: true
                    securityContext:
                      allowPrivilegeEscalation: true
                      runAsUser: 0
                      runAsGroup: 0
                      readOnlyRootFilesystem: false
                      privileged: true
            '''
            retries 2
            }
      }
                  environment {
                    GIT_SSH_COMMAND = 'ssh -o StrictHostKeyChecking=no' // Skip host key checking
                    DOCKERHUB_CREDS = credentials('docker-hub')
                    USERNAME = "${env.DOCKERHUB_CREDS_USR}"
                    PASSWORD = "${env.DOCKERHUB_CREDS_PSW}"
                  }
              stages {
                    stage('Checkout') {
                      steps {
                        git branch: 'dev', url: 'https://github.com/jmontilla202/inadev-devops-exercise.git'
                      }
                    }
                    stage('Build') {
                      steps {
                        container('golang') {
                        sh '''
                          cd src
                          go get "github.com/gin-gonic/gin"
                          #go build -buildvcs=false
                        '''
                      }
                      container('docker') {
                        sh '''
                          dockerd --iptables=false --tls=false --bridge=none -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock --data-root /var/lib/docker &
                          sleep 5
                          docker login -u $USERNAME -p $PASSWORD
                          docker build -t jose9123/wapi:latest .
                          docker push jose9123/wapi:latest
                          docker images
                        '''
                      }
                    }
                  }
                  stage('Deploy') {
                    steps {
                      sh '''
                        echo deply
                      '''
                    }
                  }
            }
            }