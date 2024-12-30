resource "vultr_iso_private" "talos_iso" {
  url = "https://factory.talos.dev/image/376567988ad370138ad8b2698212367b8edcb69b5fd68c80be1f2ec7d603b4ba/${var.talos_image_version}/vultr-amd64.iso"
}
