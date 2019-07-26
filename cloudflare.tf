provider "cloudflare" {
    email = "${var.cloudflare_email}"
    token = "${var.cloudflare_token}"
}

resource "cloudflare_record" "master_cname" {
  domain = "${var.cloudflare_zone}"
  name = "${var.master_cname}"
  value = "${var.public_master_vip}"
  type = "CNAME"
  ttl = 1
  depends_on = ["acme_certificate.master_certificate"]
}

resource "cloudflare_record" "app_cname" {
  domain = "${var.cloudflare_zone}"
  name = "*.${var.app_cname}"
  value = "${var.public_app_vip}"
  type = "CNAME"
  ttl = 1
  depends_on = ["acme_certificate.app_subdomain_certificate"]
}

resource "cloudflare_record" "bastion_dns_a" {
  domain = "${var.cloudflare_zone}"
  name = "${var.bastion_hostname}"
  value = "${var.bastion_public_ip}"
  type = "A"
  ttl = 1
}

resource "cloudflare_record" "master_dns_a" {
  count = "${length(var.master_private_ip)}"
  domain = "${var.cloudflare_zone}"
  name = "${element(var.master_hostname, count.index)}"
  value = "${element(var.master_private_ip, count.index)}"
  type = "A"
  ttl = 1
}

resource "cloudflare_record" "infra_dns_a" {
  count = "${length(var.infra_private_ip)}"
  domain = "${var.cloudflare_zone}"
  name = "${element(var.infra_hostname, count.index)}"
  value = "${element(var.infra_private_ip, count.index)}"
  type = "A"
  ttl = 1
}

resource "cloudflare_record" "worker_dns_a" {
  count = "${length(var.app_private_ip)}"
  domain = "${var.cloudflare_zone}"
  name = "${element(var.app_hostname, count.index)}"
  value = "${element(var.app_private_ip, count.index)}"
  type = "A"
  ttl = 1
}

resource "cloudflare_record" "gluster_dns_a" {
  count = "${length(var.storage_private_ip)}"
  domain = "${var.cloudflare_zone}"
  name = "${element(var.storage_hostname, count.index)}"
  value = "${element(var.storage_private_ip, count.index)}"
  type = "A"
  ttl = 1
}
