# data for source template
data "vsphere_virtual_machine" "centos7" {
  name          = "centos7"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

# create test vm 
resource "vsphere_virtual_machine" "vsphere-centos7" {
  name = "vsphere-centos7"

  depends_on = [
    "data.vsphere_virtual_machine.centos7",
  ]

  datastore_id = "${data.vsphere_datastore.datastore.id}"
  num_cpus             = 2
  num_cores_per_socket = 2
  memory               = 2048
  folder               = "${var.VSPHERE_FOLDER}"
  guest_id             = "${data.vsphere_virtual_machine.centos7.guest_id}"
  resource_pool_id     = "${data.vsphere_resource_pool.pool.id}"

  lifecycle {
    ignore_changes = [
      "annotation",
      "vapp",
    ]
  }

  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "vmxnet3"
  }

  disk {
    label            = "disk0"
    thin_provisioned = "true"
    size             = "${data.vsphere_virtual_machine.centos7.disks.0.size}"
  }

  

  clone {
    template_uuid = "${data.vsphere_virtual_machine.centos7.id}"
    linked_clone  = "false"

    customize {
      linux_options {
        host_name = "vsphere-centos7"
        domain    = ".local"
      }

      network_interface {}
    }
  }
}

output "vSphere-centos7" {
  value = "${vsphere_virtual_machine.vsphere-centos7.guest_ip_addresses.0}"
}
