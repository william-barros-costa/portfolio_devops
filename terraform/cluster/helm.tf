resource "helm_release" "nginx_ingress_controller" {
  name = "ingress-nginx" 
  chart = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  namespace = "ingress-nginx"
  create_namespace = true

  # Baremetal Kubernetes cluster has no LoadBalancer. If really needed install MetalLB
  set = [
    {
      name  = "controller.service.type"
      value = "NodePort"
    }
  ] 
}


resource "helm_release" "harbor_chart" {
  name = "harbor" 
  chart = "harbor"
  repository = "https://helm.goharbor.io"
  namespace = "harbor"
  create_namespace = true
}
