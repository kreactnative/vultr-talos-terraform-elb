resource "local_file" "talosctl_config" {
  depends_on = [
    vultr_instance.control_plane_instance,
    vultr_instance.worker_instance,
    vultr_load_balancer.talos_lb
  ]
  content = templatefile("${path.root}/templates/talosctl.tmpl",
    {
      load_balancer      = vultr_load_balancer.talos_lb.ipv4,
      node_map_masters   = tolist(vultr_instance.control_plane_instance.*.main_ip),
      node_map_workers   = tolist(vultr_instance.worker_instance.*.main_ip),
      primary_controller = vultr_instance.control_plane_instance[0].main_ip
    }
  )
  filename        = "talos_setup.sh"
  file_permission = "755"
}

resource "local_file" "cilium_lb_ip_config" {
  depends_on = [
    vultr_instance.control_plane_instance,
  ]
  content = templatefile("${path.root}/templates/cilium-lb-ip.tmpl",
    {
      master_ipv4 = vultr_instance.control_plane_instance[0].main_ip,
      master_ipv6 = vultr_instance.control_plane_instance[0].v6_main_ip
    }
  )
  filename = "kubernetes/cilium-lb-ip.yaml"
}

resource "local_file" "istio_gateway_config" {
  depends_on = [
    vultr_instance.control_plane_instance,
  ]
  content = templatefile("${path.root}/templates/istio-gateway.tmpl",
    {
      gateway_name = "vultr-gateway",
      domain_name  = var.cloudflare_domain_name,
      secret_name  = "vultr-domain-cert-prd"
    }
  )
  filename = "kubernetes/istio-gateway.yaml"
}



resource "null_resource" "create_cluster" {
  depends_on = [local_file.talosctl_config]
  provisioner "local-exec" {
    command = "/opt/homebrew/bin/bash talos_setup.sh"
  }
}
