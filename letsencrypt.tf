# use letsencrypt to generate master cert and router cert
# we'll use cloudflare as a dns challenge
provider "acme" {
  server_url = "${var.letsencrypt_api_endpoint}"
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "reg" {
    account_key_pem = "${tls_private_key.private_key.private_key_pem}"
    email_address   = "${var.letsencrypt_email}"
}

resource "acme_certificate" "master_certificate" {
  account_key_pem           = "${acme_registration.reg.account_key_pem}"
  common_name               = "${var.cluster_cname}"

  dns_challenge {
    provider = "${var.letsencrypt_dns_provider}"
    config = {
        CLOUDFLARE_EMAIL   = "${var.cloudflare_email}"
        CLOUDFLARE_API_KEY = "${var.cloudflare_token}"
    }
  }
}

resource "acme_certificate" "app_subdomain_certificate" {
  account_key_pem           = "${acme_registration.reg.account_key_pem}"
  common_name               = "*.${var.app_subdomain}"

  dns_challenge {
    provider = "${var.letsencrypt_dns_provider}"
    config = {
        CLOUDFLARE_EMAIL   = "${var.cloudflare_email}"
        CLOUDFLARE_API_KEY = "${var.cloudflare_token}"
    }
  }
}

resource "null_resource" "write_letsencrypt_master_certs" {
  triggers = {
    cert = "${acme_certificate.master_certificate.certificate_pem}${acme_certificate.master_certificate.issuer_pem}"
  }

  connection {
    host          = "${var.bastion_public_ip}"
    user          = "${var.ssh_username}"
    private_key   = "${file(var.bastion_ssh_key_file)}"
  }

  provisioner "file" {
    content = <<EOF
${acme_certificate.master_certificate.certificate_pem}${acme_certificate.master_certificate.issuer_pem}
EOF
    destination = "/root/master.crt"
  }

  provisioner "file" {
    content = <<EOF
${acme_certificate.master_certificate.private_key_pem}
EOF
    destination = "/root/master.key"
  }
}

resource "null_resource" "write_letsencrypt_router_certs" {
  triggers = {
    cert = "${acme_certificate.app_subdomain_certificate.certificate_pem}${acme_certificate.app_subdomain_certificate.issuer_pem}"
  }

  connection {
    host          = "${var.bastion_public_ip}"
    user          = "root"
    private_key   = "${file(var.bastion_ssh_key_file)}"
  }

  provisioner "file" {
    content = <<EOF
${acme_certificate.app_subdomain_certificate.certificate_pem}${acme_certificate.app_subdomain_certificate.issuer_pem}
EOF
    destination = "/root/router.crt"
  }

  provisioner "file" {
    content = <<EOF
${acme_certificate.app_subdomain_certificate.private_key_pem}
EOF
    destination = "/root/router.key"
  }
}

# write out the letsencrypt CA
resource "null_resource" "write_letsencrypt_router_ca_certs" {
  triggers = {
    cert = "${acme_certificate.app_subdomain_certificate.certificate_pem}${acme_certificate.app_subdomain_certificate.issuer_pem}"
  }

  connection {
    host          = "${var.bastion_public_ip}"
    user          = "root"
    private_key   = "${file(var.bastion_ssh_key_file)}"
  }

  provisioner "remote-exec" {
    inline = [
      <<EOF
curl -o /root/router_ca.crt https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem.txt
EOF
    ]
  }
}
