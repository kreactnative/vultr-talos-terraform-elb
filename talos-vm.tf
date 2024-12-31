resource "vultr_instance" "control_plane_instance" {
  count       = var.control_plane_count
  plan        = var.control_plane_plan
  region      = var.region
  iso_id      = vultr_iso_private.talos_iso.id
  label       = "talos-control-plane-${count.index}"
  tags        = ["talos", "kubernetes", "control-plane"]
  hostname    = "talos-control-plane-${count.index}"
  enable_ipv6 = true
}
resource "vultr_instance" "worker_instance" {
  count       = var.worker_count
  plan        = var.worker_plan
  region      = var.region
  iso_id      = vultr_iso_private.talos_iso.id
  label       = "talos-worker-${count.index}"
  tags        = ["talos", "kubernetes", "worker"]
  hostname    = "talos-worker-${count.index}"
  enable_ipv6 = true
}
