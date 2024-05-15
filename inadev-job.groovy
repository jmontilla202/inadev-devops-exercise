pipelineJob('wapi-app') {
            definition {
                cps {
                  script("""
                      pipeline {
                          agent any

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
                                      go build -buildvcs=false -o wapi
                                    '''
                                  }
                                  container('docker') {
                                    sh '''
                                        dockerd --iptables=false --tls=false --bridge=none -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock --data-root /var/lib/docker &
                                        #// docker login -u $USERNAME -p $PASSWORD
                                        sleep 10
                                        docker build -t jose9123/wapi:latest .
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
                  """.stripIndent())
                sandbox()
                }
     }
}
        