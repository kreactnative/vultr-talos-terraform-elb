data "cloudflare_zone" "cl_domain" {
  name = var.cloudflare_domain_name
}
resource "cloudflare_record" "k8s_ipv4" {
  zone_id = data.cloudflare_zone.cl_domain.id
  name    = "*.vultr"
  content = vultr_instance.control_plane_instance[0].main_ip
  type    = "A"
  proxied = false
}

resource "cloudflare_record" "k8s_ipv6" {
  zone_id = data.cloudflare_zone.cl_domain.id
  name    = "*.vultr"
  content = vultr_instance.control_plane_instance[0].v6_main_ip
  type    = "AAAA"
  proxied = false
}
