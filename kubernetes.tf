terraform {
  required_providers {
    kubernetes = {      
      source = "hashicorp/kubernetes"
      }
    docker = {
      source = "kreuzwerker/docker"
      version = "2.11.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"  
}

provider "docker" {
  host = "tcp://localhost:2376"
}

resource "kubernetes_namespace" "flaskapp" {
  metadata {
    annotations = {
      name = "flaskapp"
    }

    labels = {
      App = "ScalableNginxExample"
    }

    name = "flaskapp"
  }
}
resource "kubernetes_deployment" "flaskapp" {
  
  metadata {
    namespace = kubernetes_namespace.flaskapp.metadata.0.name
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
          image = "annaarakeyan/terraform:latest"
          name  = "flaskapp"

          port {
            container_port = 8085
          }
        }
      }
    }
  }
}
resource "kubernetes_service" "flaskapp" {
  metadata {
    namespace = kubernetes_namespace.flaskapp.metadata.0.name
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

