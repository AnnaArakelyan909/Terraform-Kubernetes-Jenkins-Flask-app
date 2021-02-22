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
                bat 'terraform init'
            }
        }

        stage('Terraform Apply'){
            steps {
                bat 'xcopy -i /etc/kubernetes/admin.conf $HOME/'
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
