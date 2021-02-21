pipeline{
    agent any
    tools {
        terraform 'terraform'
    }
    stages {
        stage('SCM Checkout'){
            steps {
                checkout scm                
            }
        }
        
        /* stage('Delete and Restart Kind Cluster'){
            steps {                
                sh 'kind create cluster --name flask-app --config=Terraform-Kubernetes-Jenkins-Flask-app/kind-config.yaml'
            }
        } */


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
