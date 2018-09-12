# Configure the OpenStack Provider
provider "openstack" {
    tenant_name = "${var.OS_TENANT_NAME}"
    user_name  = "${var.OS_USERNAME}"
    password  = "${var.OS_PASSWORD}"
    auth_url  = "${var.OS_AUTH_URL}"
}
