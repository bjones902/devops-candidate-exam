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
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
        stage("Execute Lambda") {
            steps {
                sh 'aws lambda invoke --function-name invokeAPI --cli-binary-format raw-in-base64-out --payload \'{ "subnet_id": "subnet-04625301f1d2eee6a", "name": "Brandon Jones", "email": "jones.brandon@siemens.com" }\' --log-type tail response.json'
            }
        }
    }
}