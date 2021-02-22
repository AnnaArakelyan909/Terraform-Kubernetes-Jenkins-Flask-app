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
        
        stage('Delete and Create New Cluster'){
            steps {
                // bat 'kind delete cluster --name flask-app'
                // bat 'kind create cluster --name flask-app --config kind-config.yaml'
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
            
         stage('Info'){
            steps {
                
                bat 'kubectl get all --all-namespaces'
            }   
        }
        

    }
}
