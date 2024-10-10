#!/bin/bash

JENKINS_URL="http://jenkins.emagetech.co:8080"
USER="admin"
# API_TOKEN=fefa349a155745839891ae1d3cca2405
API_TOKEN=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)

# List of DevOps plugins to install
PLUGINS=(
  "git"                      # Git integration
  "pipeline"                 # Pipeline support
  "workflow-aggregator"       # Pipeline: Aggregator
  "docker-plugin"            # Docker integration
  "blueocean"                # Blue Ocean UI for Jenkins Pipelines
  "ansible"                  # Ansible integration
  "kubernetes"               # Kubernetes plugin
  "build-monitor-plugin"      # Build Monitor View
  "credentials-binding"       # Binding credentials to variables
  "job-dsl"                  # Job DSL to automate job creation
  "matrix-auth"              # Matrix-based security
  "email-ext"                # Extended email notifications
  "slack"                    # Slack notifications
  "github"                   # GitHub integration
  "bitbucket"                # Bitbucket integration
  "gitlab-plugin"            # GitLab integration
  "subversion"               # Subversion SCM
  "timestamper"              # Add timestamps to Console Output
  "nodejs"                   # NodeJS build environment
  "maven-plugin"             # Apache Maven support
  "aws-credentials"          # AWS credentials support
  "aws-java-sdk"             # AWS SDK support
  "cloudbees-folder"         # Folders for organizing jobs
  "credentials"              # Credentials management
  "ssh-agent"                # SSH agent for Jenkins
  "ssh-credentials"          # SSH Credentials Plugin
  "terraform"                # Terraform support
  "packer-plugin"            # HashiCorp Packer support
  "ec2"                      # Amazon EC2 support
  "pipeline-github-lib"       # Pipeline GitHub Libraries
  "pipeline-utility-steps"    # Pipeline Utility Steps
  "ws-cleanup"               # Workspace Cleanup
  "metrics"                  # Metrics plugin
  "junit"                    # JUnit support
  "testng-plugin"            # TestNG Results support
  "xunit"                    # xUnit test results
  "jacoco"                   # Code coverage report for JaCoCo
  "checkstyle"               # Checkstyle report
  "findbugs"                 # FindBugs report
  "sonar"                    # SonarQube integration
  "gerrit-trigger"           # Gerrit Trigger plugin
  "htmlpublisher"            # HTML Publisher plugin
  "artifactory"              # JFrog Artifactory support
  "nexus-artifact-uploader"  # Nexus Repository integration
  "fortify"                  # Fortify security plugin
  "dependency-check-jenkins" # OWASP Dependency-Check
  "zap"                      # OWASP ZAP Security Scanner
  "prometheus"               # Prometheus monitoring
  "grafana"                  # Grafana integration
  "pipeline-stage-view"      # Pipeline Stage View
  "docker-workflow"          # Docker Pipeline support
  "docker-commons"           # Docker Commons
  "kubernetes-credentials"   # Kubernetes Credentials
  "ansicolor"                # AnsiColor for colored console output
  "cloud-stats"              # Cloud Statistics Plugin
  "pipeline-milestone-step"  # Pipeline Milestone Step Plugin
  "simple-theme-plugin"      # Simple Theme Plugin for Jenkins UI
  "google-compute-engine"    # Google Compute Engine Plugin
  "dependency-track"         # OWASP Dependency-Track
  "azure-credentials"        # Microsoft Azure Credentials
  "azure-vm-agents"          # Azure VM Agents
  "openstack-cloud"          # OpenStack Cloud Plugin
  "pipeline-aws"             # AWS Pipeline Steps Plugin
  "kubernetes-pipeline"      # Kubernetes Pipeline Plugin
  "docker-build-publish"     # Docker Build and Publish Plugin
)

# Function to install a Jenkins plugin
install_plugin() {
  local plugin_name=$1
  echo "Installing plugin: $plugin_name"
  curl -X POST --user "$USER:$API_TOKEN" "$JENKINS_URL/pluginManager/installNecessaryPlugins" --data "<jenkins><install plugin='$plugin_name@latest' /></jenkins>"
}

# Iterate over all plugins and install them
for plugin in "${PLUGINS[@]}"; do
  install_plugin "$plugin"
done

# Restart Jenkins after installation (optional but recommended)
echo "Restarting Jenkins to apply plugin changes..."
curl -X POST --user "$USER:$API_TOKEN" "$JENKINS_URL/safeRestart"