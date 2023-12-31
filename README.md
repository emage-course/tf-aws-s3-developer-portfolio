### Scenario

Your team has been using a Jenkins server locally for their CI/CD pipeline and now wants to move it into the cloud. You have been tasked with setting up a Jenkins server on AWS.

### Requirements

The Jenkins server must be deployed on an EC2 instance
The EC2 instance should be accessible via the internet on port 8080
Only you should be able to access the EC2 instance via SSH
Use Terraform for Infrastructure as Code

- Install Required Plugins

### How will we accomplish this task with Terraform?

1. Create the VPC

2. Create the Internet Gateway and attach it to the VPC using a Route Table

3. Create a Public Subnet and associate it with the Route Table

4. Create a Security Group for the EC2 Instance

5. Create a script to automate the installation of Jenkins on the EC2 Instance

6. Create the EC2 Instance and attach an Elastic IP and Key Pair to it

7. Verify that everything works

### Deploy Code to Verify

Let’s apply the code to verify everything is working as it should before creating our pipeline.

1. Run terraform fmt -recursive to format all the Terraform files.

2. Run terraform validate to check the syntax of the code.

3. Run terraform plan to view the infrastructure that will be created.

4. Run terraform apply to provision the infrastructure. When prompted type "ye" and click enter.

https://www.jenkins.io/solutions/github/



#############

AWS_DEFAULT_REGION=<region of bucket>

AWS_ACCESS_KEY_ID=<aws id>

AWS_SECRET_ACCESS_KEY=<your secret access key>

#############

<!-- 
pipeline {
    agent any
pipeline {
    agent any
    stages {
        stage('deploy') {
            steps {
              sh "aws configure set region $AWS_DEFAULT_REGION" 
              sh "aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID"  
              sh "aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY"
              sh "terraform init && terraform fmt && terraform validate && terraform plan"
              sh "time terraform fmt && terraform validate && terraform apply -auto-approve"
            }
        }
    }
} -->



pipeline {
    agent any

    stages {
        stage('Pre-Build') {
            steps {
                echo 'Pre-Build...'
                echo 'Send status Pre-Build to Mail, Telegram, Slack...'
            }
        }
        stage('Build') {
            steps {
                echo 'Building...'
                echo 'Running docker build...'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Push') {
            steps {
                echo 'Pushing...'
                echo 'Running docker push...'
            }
        }
    }
    
    post {
        success {
            echo 'Success...'
            echo 'Send status Success to Mail, Telegram, Slack...'
        }
        failure {
            echo 'Failure...'
            echo 'Send status Failure to Mail, Telegram, Slack...'
        }
    }

}

### Configure Jenkins Job

Configure the Jenkins job or pipeline with the necessary settings, such as repository URL, credentials, and triggers (e.g., GitHub webhook, periodic builds, etc.).

### Install Required Plugins

Step-1
Now, We should install the Terraform plugin on Jenkins which makes Jenkins interact with terraform. Follow the below steps to install the Terraform plugin:

Step-2
Depending on your project's needs, you may need to install Jenkins plugins for version control systems (e.g. Git), and any other required integrations for cost control, drift detection and policies.

Dashboard >> Manage Jenkins >> Manage Plugin

Step-3
Now we need to configure the global tool for terraform. In the install directory, we need to pass the path of terraform where we have installed terraform and save it. Follow the below step to configure:

Dashboard >> Manage jenkins >> Global Tool Configuration

Step-4
Now create a job to run the pipeline. We just need to select the pipeline option and ok to create a pipeline. Follow the below steps:

Dashboard >> new Item >> give name and create

**Declarative Directive Generator** and then select terraform to generate pipeline. Copy that script into the pipeline.

### Create a Jenkins Job or Pipeline

You can create a Jenkins job or pipeline based on your project's requirements. The choice between a freestyle job or a pipeline depends on your needs and complexity. A pipeline is more versatile and recommended for complex workflows.

### Run the Job
Trigger the Jenkins job manually or configure it to be triggered automatically based on your requirements.

Running Terraform in Jenkins involves setting up a Jenkins job or pipeline to automate your infrastructure provisioning and 

Pipeline: Create a Jenkinsfile in your project repository to define the pipeline. Below is an example Jenkinsfile for running Terraform commands using a declarative pipeline:

pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Terraform Init') {
            steps {
                sh 'cd /path/to/your/terraform/project && terraform init'
            }
        }
        stage('Terraform Apply') {
            steps {
                sh 'cd /path/to/your/terraform/project && terraform apply -auto-approve'
            }
        }
    }
}

### Freestyle Job: Create a new Jenkins job. In the job configuration, add a build step (Execute shell) to run Terraform commands. Here's an example of running Terraform init and apply:

cd /path/to/your/terraform/project
terraform init
terraform apply -auto-approve


---------------------------------------

**Step 1:** Installing Terraform Plugin on Jenkins
Navigate to the: Dashboard >> Manage Jenkins >> Manage Plugin

**Step 2:** Installing Terraform Binary
Navigate to the: “Dashboard >> Manage Jenkins >> Global Tool Configuration” page, and scroll to the section that represents Terraform.


### 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