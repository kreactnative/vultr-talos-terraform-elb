terraform {
  required_providers {
    vultr = {
      source  = "vultr/vultr"
      version = "2.23.1"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

# Configure the Vultr Provider
provider "vultr" {
  api_key     = var.vult_api_key
  rate_limit  = 100
  retry_limit = 3
}

provider "cloudflare" {
  api_token = var.cloudflare_api_key
}


resource "null_resource" "cleanup" {
  provisioner "local-exec" {
    command     = "rm -f talos_setup.sh talosconfig worker.yaml controlplane.yaml && rm -rf kubernetes/cilium-lb-ip.yaml kubernetes/istio-gateway.yaml"
    working_dir = path.root
  }
}
