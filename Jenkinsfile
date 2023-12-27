pipeline {
    agent any
    environment {
        AWS_DEFAULT_REGION="us-east-2"
        AWS_ACCESS_KEY_I="$AWS_ACCESS_KEY_ID"
        AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY"
    }
   
    stages {

        stage('Cloning Git') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '', url: 'https://github.com/github-actions-org1/tf-aws-jenkins.git']]])     
            }
        }
  
    // Building Docker images
    stage('Terraform Plan') {
      steps{
        script {
          sh "terraform init && terraform fmt && terraform validate && terraform plan"
        }
      }
    }
   
    // Uploading Docker images into AWS ECR
    stage('Terraform Apply') {
     steps{  
         script {
                sh "time terraform fmt && terraform validate && terraform apply -auto-approve"
         }
        }
      }
    }
}

