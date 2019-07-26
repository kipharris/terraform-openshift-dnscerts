## terraform-openshift-cloudflare

This is meant to be used as a module, make sure your module implementation sets all the variables in its terraform.tfvars file

```terraform
module "cloudflare" {
    source                = "git::ssh://git@github.ibm.com/ncolon/terraform-openshift-cloudflare.git"
    cloudflare_dns        = "${var.cloudflare_dns}"
    cloudflare_email      = "${var.cloudflare_email}"
    cloudflare_token      = "${var.cloudflare_token}"
    cloudflare_zone       = "${var.domain}"
    public_master_vip     = "${module.infrastructure.public_master_vip}"
    public_app_vip        = "${module.infrastructure.public_app_vip}"
    master_cname          = "${var.master_cname}-${random_id.tag.hex}"
    app_cname             = "${var.app_cname}-${random_id.tag.hex}"
    master_hostname       = "${module.infrastructure.master_hostname}"
    app_hostname          = "${module.infrastructure.app_hostname}"
    infra_hostname        = "${module.infrastructure.infra_hostname}"
    storage_hostname      = "${module.infrastructure.storage_hostname}"
    master_private_ip     = "${module.infrastructure.master_private_ip}"
    app_private_ip        = "${module.infrastructure.app_private_ip}"
    infra_private_ip      = "${module.infrastructure.infra_private_ip}"
    storage_private_ip    = "${module.infrastructure.storage_private_ip}"
}
```

## Module Inputs Variables

|Variable Name|Description|Default Value|Type|
|-------------|-----------|-------------|----|
|cloudflare_dns|Control variable.  Determines if module is used|false|bool|
|cloudflare_email|Cloudflare Email Login|-|string|
|cloudflare_token|Cloudflare API Token|-|string|
|public_master_vip|Master Loadbalancer VIP ex:`ncolon-ocp-master-76fbf24d-625675-wdc04.clb.appdomain.cloud`|-|string|
|public_app_vip|App Loadbalancer VIP ex:`ncolon-ocp-app-76fbf24d-625675-wdc04.clb.appdomain.cloud`|-|string|
|master_cname|CNAME to be used for your custom domain. Ex: `ocp-ncolon-xxxxx`|-|string|
|master_hostname|Hostnames of Master Nodes|-|list|
|app_hostname||Hostnames of App Nodes|-|list|
|infra_hostname||Hostnames of Infra Nodes|-|list|
|storage_hostname||Hostnames of Storage Nodes|-|list|
|master_private_ip|Private IPv4 Address of Master Nodes|-|list|
|app_private_ip|Private IPv4 Address of App Nodes|-|list|
|infra_private_ip|Private IPv4 Address of Infra Nodes|-|list|
|storage_privage_ip|Private IPv4 Address of Storage Nodes|-|list|


## Module Output
This module produces no output

----
# terraform-openshift-dnscerts
