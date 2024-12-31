variable "vult_api_key" {
  type      = string
  sensitive = true
}
variable "region" {
  type = string
}
variable "talos_image_version" {
  type = string
}
variable "cloudflare_api_key" {
  type      = string
  sensitive = true
}
variable "cloudflare_domain_name" {
  type      = string
}
variable "worker_count" {
  type = number
}
variable "worker_plan" {
  type = string
  default = "vc2-1c-1gb"
}
variable "control_plane_count" {
  type = number
}
variable "control_plane_plan" {
  type = string
  default = "vc2-2c-4gb"
}