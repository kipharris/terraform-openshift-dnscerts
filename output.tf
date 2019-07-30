resource "random_id" "completed" {
    byte_length = 1
    depends_on = [
        "null_resource.write_letsencrypt_master_certs",
        "null_resource.write_letsencrypt_router_certs",
        "null_resource.write_letsencrypt_router_certs",
        "cloudflare_record.master_cname",
        "cloudflare_record.app_cname",
        "cloudflare_record.bastion_dns_a",
        "cloudflare_record.master_dns_a",
        "cloudflare_record.infra_dns_a",
        "cloudflare_record.worker_dns_a",
        "cloudflare_record.gluster_dns_a"
        "null_resource.dependency"
    ]
}

output "completed" {
    value = "${random_id.completed.hex}"
}

resource "null_resource" "dependency" {
  triggers = {
    all_dependencies = "${join(",", var.dependencies)}"
  }
}
