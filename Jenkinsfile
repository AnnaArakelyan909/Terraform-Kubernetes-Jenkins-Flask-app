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
                sh 'kind delete cluster --name flask-app'
                sh 'curl https://raw.githubusercontent.com/hashicorp/learn-terraform-deploy-nginx-kubernetes-provider/master/kind-config.yaml --output kind-config.yaml'
                sh 'kind create cluster --name flask-app --config kind-config.yaml'
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
