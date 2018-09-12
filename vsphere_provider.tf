provider "vsphere" {
  user           = "${var.VSPHERE_USER}"
  password       = "${var.VSPHERE_PASSWORD}"
  vsphere_server = "${var.VSPHERE_SERVER}"

  # if you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "${var.VSPHERE_DATACENTER}"
}

data "vsphere_datastore" "datastore" {
  name          = "${var.VSPHERE_DATASTORE}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {
  name          = "${var.VSPHERE_RESOURCE_POOL}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "${var.VSPHERE_NETWORK}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
