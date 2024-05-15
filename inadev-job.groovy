  pipelineJob('wapi-app') {
        triggers {
            hudsonStartupTrigger {
              nodeParameterName("Built-In Node")
              label("master")
              quietPeriod("60")
              runOnChoice("False")
            }
        }
        definition {
          cps {
              script("""
                pipeline {
                      agent any
                      environment {
                          GIT_SSH_COMMAND = 'ssh -o StrictHostKeyChecking=no' // Skip host key checking
                      }
                      stages {
                         stage('Checkout') {
                            steps { 
                              git branch: 'dev', url: 'https://github.com/jmontilla202/inadev-devops-exercise.git' 
                            }
                          }
                          stage('Build') {
                              steps {
                                  echo 'hello'
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