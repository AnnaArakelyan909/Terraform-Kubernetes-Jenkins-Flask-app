terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    docker = {
      source = "kruzwerker/docker"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}
resource "kubernetes_deployment" "flask-app" {
  metadata {
    name = "flask-app"
    
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "flask-app"
      }
    }
    template {
      metadata {
        labels = {
          App = "flask-app"
        }
      }
      spec {
        container {
          image = "annaarakeyan/case-study-project"
          name  = "flask-app"

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}
resource "kubernetes_service" "flask-app" {
  metadata {
    name = "flask-app-service"
  }
  spec {
    selector = {
      App = kubernetes_deployment.flask.spec.0.template.0.metadata[0].labels.App
    }
    port {
      node_port   = 30201
      port        = 80
      target_port = 80
    }

    type = "NodePort"
  }
}
