### Scenario

Your team has been using a Jenkins server locally for their CI/CD pipeline and now wants to move it into the cloud. You have been tasked with setting up a Jenkins server on AWS.

### Requirements

The Jenkins server must be deployed on an EC2 instance
The EC2 instance should be accessible via the internet on port 8080
Only you should be able to access the EC2 instance via SSH
Use Terraform for Infrastructure as Code

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

