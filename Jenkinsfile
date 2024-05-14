pipeline {
    agent any
        tools {
        go 'Go-1.21.9'
    }
    environment {
        GIT_SSH_COMMAND = 'ssh -o StrictHostKeyChecking=no' // Skip host key checking
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'git@github.com:jmontilla202/inadev-devops-exercise.git'
            }
        }

        stage('Build') {
            steps {
                sh '''go version
                    cd "wtw/src"
                    go get "github.com/gin-gonic/gin"
                    go build'''
            }
        }
        // stage('Build image') {
        //     steps {
        //         echo 'Starting to build docker image'

        //         script {
        //             return docker.build("wtw:${env.BUILD_ID}", "-f wtd/srs/Dockerfile .")
        //             // customImage.push()
        //         }
        //     }
        // }
        stage('Test') {
            steps {
                sh 'echo test'
            }
        }
        
        stage('Deploy') {
            steps {
                sh 'echo deploy'
            }
        }
    }
}
