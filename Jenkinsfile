pipeline {
    agent any
    stages {
        stage("Build") {
            steps {
                git url: 'https://github.com/bjones902/devops-candidate-exam', branch: 'main'
            }
        }
        stage("Terraform Init") {
            steps {
                sh 'terraform init'
            }
        }
        stage("Terraform Validate") {
            steps {
                sh 'terraform validate'
            }
        }
        stage("Terraform Plan") {
            steps {
                sh 'terraform plan'
            }
        }
        stage("Terraform Apply") {
            steps{
                sh 'terraform apply -auto-approve'
            }
        }
    }
}