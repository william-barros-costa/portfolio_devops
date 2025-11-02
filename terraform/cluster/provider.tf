provider "helm" {
  kubernetes = {
    config_path = "../../resources/kubeconf.conf"
  }
}
