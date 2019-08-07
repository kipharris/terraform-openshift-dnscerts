## terraform-openshift-dsncerts

This is meant to be used as a module, make sure your module implementation sets all the variables in its terraform.tfvars file

```terraform
module "dnscerts" {
    source                   = "git::ssh://git@github.ibm.com/ncolon/terraform-openshift-dnscerts.git"
    dnscerts                 = "${var.dnscerts}"
    cloudflare_email         = "${var.cloudflare_email}"
    cloudflare_token         = "${var.cloudflare_token}"
    cloudflare_zone          = "${var.domain}"
    letsencrypt_email        = "${var.letsencrypt_email}"
    letsencrypt_dns_provider = "${var.letsencrypt_dns_provider}"
    letsencrypt_api_endpoint = "${var.letsencrypt_api_endpoint}"
    public_master_vip        = "${module.infrastructure.public_master_vip}"
    public_app_vip           = "${module.infrastructure.public_app_vip}"
    master_cname             = "${var.master_cname}-${random_id.tag.hex}"
    app_cname                = "${var.app_cname}-${random_id.tag.hex}"
    bastion_public_ip        = "${module.infrastructure.bastion_public_ip}"
    bastion_hostname         = "${module.infrastructure.bastion_hostname}"
    master_hostname          = "${module.infrastructure.master_hostname}"
    app_hostname             = "${module.infrastructure.app_hostname}"
    infra_hostname           = "${module.infrastructure.infra_hostname}"
    storage_hostname         = "${module.infrastructure.storage_hostname}"
    master_private_ip        = "${module.infrastructure.master_private_ip}"
    app_private_ip           = "${module.infrastructure.app_private_ip}"
    infra_private_ip         = "${module.infrastructure.infra_private_ip}"
    storage_private_ip       = "${module.infrastructure.storage_private_ip}"
    cluster_cname            = "${var.master_cname}-${random_id.tag.hex}.${var.domain}"
    app_subdomain            = "${var.app_cname}-${random_id.tag.hex}.${var.domain}"
    bastion_ssh_key_file     = "${var.private_ssh_key}"
    ssh_username             = "${var.ssh_user}"
    master                   = "${var.master}"
    infra                    = "${var.infra}"
    worker                   = "${var.worker}"
    storage                  = "${var.storage}"
    bastion                  = "${var.bastion}"
    haproxy                  = "${var.haproxy}"
}
```

## Module Inputs Variables

|Variable Name|Description|Default Value|Type|
|-------------|-----------|-------------|----|
|dnscerts|Control variable.  Determines if module is used|false|bool|
|cloudflare_email|Cloudflare Email Login|-|string|
|cloudflare_token|Cloudflare API Token|-|string|
|cloudflare_zone|DNS Zone to register VMs on|"${module.infrastructure.domain}"|string|
|letsencrypt_email|Email to registrer LetsEncrypt certificates|-|string|
|letsencrypt_dns_provider|DNS provider to handle acme challenge|cloudflare|string|
|public_master_vip|Master Loadbalancer VIP ex:`ncolon-ocp-master-76fbf24d-625675-wdc04.clb.appdomain.cloud`|-|string|
|public_app_vip|App Loadbalancer VIP ex:`ncolon-ocp-app-76fbf24d-625675-wdc04.clb.appdomain.cloud`|-|string|
|master_cname|CNAME to be used for your custom domain. Ex: `ocp-ncolon-xxxxx`|-|string|
|app_cname|CNAME to be used for your apps domain. Ex: `apps.ocp-ncolon-xxxxx`|-|string|
|bastion_public_ip|Public IPv4 Address of Bastion Node|-|string|
|bastion_hostname|Hostname of Bastion Node|-|string|
|master_hostname|Hostnames of Master Nodes|-|list|
|app_hostname|Hostnames of App Nodes|-|list|
|infra_hostname|Hostnames of Infra Nodes|-|list|
|storage_hostname|Hostnames of Storage Nodes|-|list|
|haproxy_hostname|Hostnames of Storage Nodes|-|list|
|master_private_ip|Private IPv4 Address of Master Nodes|-|list|
|app_private_ip|Private IPv4 Address of App Nodes|-|list|
|infra_private_ip|Private IPv4 Address of Infra Nodes|-|list|
|storage_privage_ip|Private IPv4 Address of Storage Nodes|-|list|
|haproxy_public_ip|Public IPv4 Address of Bastion Node|-|list|
|bastion_ssh_key_file|Private SSH key for Bastion VM|-|string|
|ssh_username|SSH user.  Must have passwordless sudo access|-|string|
|bastion|A map variable for configuration of bastion node|See sample variables.tf|
|master|A map variable for configuration of master nodes|See sample variables.tf|
|infra|A map variable for configuration of infra nodes|See sample variables.tf|
|worker|A map variable for configuration of worker nodes|See sample variables.tf|
|storage|A map variable for configuration of storage nodes|See sample variables.tf|
|haproxy|A map variable for configuration of haproxy nodes|See sample variables.tf|


## Module Output
This module produces no output
