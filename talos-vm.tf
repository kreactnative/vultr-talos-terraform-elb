resource "vultr_instance" "control_plane_instance" {
  count       = 2
  plan        = "vc2-1c-2gb"
  region      = var.region
  iso_id      = vultr_iso_private.talos_iso.id
  label       = "talos-control-plane"
  tags        = ["talos", "control-plane"]
  hostname    = "talos-control-plane-${count.index}"
  enable_ipv6 = true
}
resource "vultr_instance" "worker_instance" {
  count       = 2
  plan        = "vc2-1c-2gb"
  region      = var.region
  iso_id      = vultr_iso_private.talos_iso.id
  label       = "talos-worker"
  tags        = ["talos", "worker"]
  hostname    = "talos-worker-${count.index}"
  enable_ipv6 = true
}
