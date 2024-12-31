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
