resource "vultr_load_balancer" "talos_lb" {
  region              = var.region
  label               = "talos-load-balancer"
  #balancing_algorithm = "roundrobin"
  forwarding_rules {
    frontend_protocol = "tcp"
    frontend_port     = 443
    backend_protocol  = "tcp"
    backend_port      = 6443
  }

  health_check {
    port                = 6443
    protocol            = "tcp"
    response_timeout    = 5
    unhealthy_threshold = 3
    check_interval      = 10
    healthy_threshold   = 5
  }
  attached_instances = vultr_instance.control_plane_instance.*.id
}
