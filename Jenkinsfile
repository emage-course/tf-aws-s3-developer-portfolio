pipeline {
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '', url: 'https://github.com/github-actions-org1/tf-aws-jenkins.git']]])
      }
    }

    stage('Terraform Plan') {
      steps {
        script {
          echo 'Pre-Build...'
          sh "terraform init && terraform fmt && terraform validate && terraform plan"
        }

      }
    }

    stage('Terraform Apply') {
      steps {
        script {
          echo 'Building...'
          sh "time terraform fmt && terraform validate && terraform apply -auto-approve"
        }

      }
    }

  }
  environment {
    AWS_DEFAULT_REGION = 'us-east-2'
    AWS_ACCESS_KEY_I = "$AWS_ACCESS_KEY_ID"
    AWS_SECRET_ACCESS_KEY = "$AWS_SECRET_ACCESS_KEY"
  }
}
