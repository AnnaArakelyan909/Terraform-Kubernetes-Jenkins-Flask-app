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

        stage('Terraform Init'){
            steps {
       			sh 'terraform init'
            }
        }

        stage('Terraform Apply'){
            steps {
                
                sh 'terraform apply --auto-approve'
            }
        }
        

    }
}
