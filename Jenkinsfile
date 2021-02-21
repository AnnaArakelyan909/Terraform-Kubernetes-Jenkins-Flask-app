pipeline{
    agent any
    tools {
        terraform 'terraform'
    }
    stages {
        stage('SCM Checkout'){
            steps {
                
                sh 'git clone https://github.com/jayjay2626/terraform-kubernetes-jenkins-flaskapp.git'
            }
        }
        
        stage('Delete and Restart Kind Cluster'){
            steps {
                
                sh 'kind create cluster --name terraform-flask-app --config kind-config.yaml'
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
