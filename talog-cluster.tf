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
      node_map_workers   = tolist(vultr_instance.worker_instance.*.main_ip)
      primary_controller = vultr_instance.control_plane_instance[0].main_ip
    }
  )
  filename        = "talos_setup.sh"
  file_permission = "755"
}

resource "null_resource" "create_cluster" {
  depends_on = [local_file.talosctl_config]
  provisioner "local-exec" {
    command = "/opt/homebrew/bin/bash talos_setup.sh"
  }
}
