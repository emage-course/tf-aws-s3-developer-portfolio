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

### Create a Jenkins Job or Pipeline

**Declarative Directive Generator** and then select terraform to generate pipeline. Copy that script into the pipeline.

Terraform consists of three stages of workflow:

**Write:** You define resources, which may be across multiple cloud providers and services.
**Plan:** Terraform creates an execution plan for your existing infrastructure and your configuration which describe the infrastructure it will create, update, or destroy.
**Apply:**  Terraform perform all operations in correct order.

In this script, I have written the 4 stages. The first stage is used to get code from Github. The second stage is used to make the correct format of terraform files then terraform init stage installs the required plugin in the system and finally, terraform apply is used to apply all configurations.

Step-4
In the last, We are good to build this job.

##################################

Step 1:
Create the Seed Job using DSL


Step 2:
Install Required Plugins Ensure you have Jenkins installed, and then install the following plugins through the Jenkins Plugin Manager:

- Jenkins Job DSL Plugin
- AWS CLI Plugin
- Terraform Plugin
- Pipeline Utility Steps Plugin

Step 3:
Configure AWS Credentials To allow Jenkins to interact with AWS, you need to set up AWS credentials:

- Go to “Manage Jenkins” > “Manage Credentials” > “Jenkins” Store.
- Add a new “AWS Credentials” with your AWS Access Key ID and Secret Access Key.

Step 4:
Create the Seed Job using DSL

- Create a new Freestyle project in Jenkins and name it “Seed Job — Terraform Pipeline.”
- In the “Build” section, select “Process Job DSLs” and provide the DSL script below:


Step 7:
Configure Jenkins Job

1. In Jenkins, create a new pipeline job.
2. Under the “Pipeline” section, select “Pipeline script from SCM.”
3. Provide the repository URL and specify the Jenkinsfile location (e.g., Jenkinsfile).
4. Save the job configuration.

################

How to Set Up the Jenkins + GitHub Integration
Step 1: go to your GitHub repository and click on 'Settings'.
Step 2: Click on Webhooks and then click on 'Add webhook'.
Step 3: In the 'Payload URL' field, paste your Jenkins environment URL. ...
Step 4: In the page 'Which events would you like to trigger this webhook?

### Integrate Jenkins with Github (Private repo)

Jenkins configuration to access private repo:

Go to Jenkins dashboard -> Credentials -> System -> Global credentials -> Add credentials. Give username as Jenkins or whatever you can remember. Add the Private key -> Enter directly and copy paste the same ssh keys here, click on okay.

### Prerequisite:
- Jenkins should be installed and the initial Jenkins setup needs to be done.
- A Private Github repository.

Generate ssh keys and add to Github:
For this task, we will be using ssh keys to connect to a private Github repository. You can also use username and password, later in this tutorial, I will explain where you need to change instead of ssh keys for login credentials.

- Generate your ssh keys using this blog by Github.
- Adding generated keys to the private Github repository created before.

Go to your private Github repo -> Settings -> Deploy keys.

### Jenkins configuration to access private repo:
Go to Jenkins dashboard -> Credentials -> System -> Global credentials -> Add credentials.
Give username as Jenkins or whatever you can remember. Add the Private key -> Enter directly and copy paste the same ssh keys here, click on okay.

### Webhook GitHub with Jenkins
Open your Github repository which you created and go to settings. Click on Hooks and press Add Webhook. After you are done with this follow the below image configuration and press Add webhook (green button). Now the Github webhook is also set.


![Alt text](image.png)