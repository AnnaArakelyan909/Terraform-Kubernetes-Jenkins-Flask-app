pipeline{
    agent any
    tools {
        terraform 'terraform'
    }
    stages {
        stage('Clean Workspace and SCM Checkout'){
            steps {
                cleanWs()
                checkout scm                
            }
        }
        
        stage('Terraform'){
            steps {
                bat 'terraform fmt'
            }
        }

        stage('Terraform Init'){
            steps {
                bat 'terraform init'
            }
        }

        stage('Terraform Apply'){
            steps {
                
                bat 'terraform apply --auto-approve'
            }
        }
        

    }
}
