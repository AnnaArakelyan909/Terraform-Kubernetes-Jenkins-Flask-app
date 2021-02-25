terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"  
}
resource "kubernetes_deployment" "flaskapp" {
  namespace = kubernetes_namespace.flaskapp.metadata.0.name
  metadata {
    name = "flaskapp"
    labels = {
      App = "flaskapp"
    }

  }

  spec {
    replicas = 3
    selector {
      match_labels = {
        App = "flaskapp"
      }
    }
    template {
      metadata {
        labels = {
          App = "flaskapp"
        }
      }
      spec {
        container {
          image = "annaarakeyan/terraform"
          name  = "flaskapp"

          port {
            container_port = 8085
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
resource "kubernetes_service" "flaskapp" {
  metadata {
    name = "flaskapp"
  }
  spec {
    selector = {
      App = kubernetes_deployment.flaskapp.spec.0.template.0.metadata[0].labels.App
    }
    port {
      node_port   = 30201
      port        = 8085
      target_port = 8085
    }

    type = "NodePort"
  }
}

