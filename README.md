## create terraform.tfvars
```
vult_api_key           = "change me"
region                 = "sgp"
talos_image_version    = "v1.9.0"

control_plane_count = 2
control_plane_plan  = "vc2-2c-4gb"

worker_count = 1
worker_plan  = "vc2-1c-1gb"

cloudflare_api_key     = "change me"
cloudflare_domain_name = "change me"

```