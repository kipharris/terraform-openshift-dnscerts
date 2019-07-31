variable "dnscerts" {
    default = false
}

variable "cloudflare_email" {}
variable "cloudflare_token" {}

variable "public_app_vip" {}
variable "public_master_vip" {}

variable "master_cname" {}
variable "app_cname" {}

variable "cloudflare_zone" {}

variable "bastion_public_ip" {}
variable "bastion_hostname" {}
variable "master_hostname" { type="list" }
variable "app_hostname" { type="list" }
variable "infra_hostname" { type="list" }
variable "storage_hostname" { type="list" }
variable "haproxy_hostname" { type="list" }
variable "master_private_ip" { type="list" }
variable "app_private_ip" { type="list" }
variable "infra_private_ip" { type="list" }
variable "storage_private_ip" { type="list" }
variable "haproxy_public_ip" { type="list" }

variable "letsencrypt_email" {
  description = "email address used to register with letsencrypt"
}

variable "letsencrypt_api_endpoint" {
  default = "https://acme-v02.api.letsencrypt.org/directory"
  description = "API endpoint.  default to prod.  for staging use: https://acme-staging-v02.api.letsencrypt.org/directory"
}

variable "letsencrypt_dns_provider" {
  description = "dns provider for dns01 challenge"
}

variable "app_subdomain" {
  description = "subdomain where apps will be deployed"
}

variable "cluster_cname" {
  description = "dns CNAME for master VIP"
}


variable "bastion_ssh_key_file" {}
variable "ssh_username" {
    default = "root"
}

variable "bastion" {type = "map"}
variable "master"  {type = "map"}
variable "infra"   {type = "map"}
variable "worker"  {type = "map"}
variable "storage" {type = "map"}
variable "haproxy" {type = "map"}
