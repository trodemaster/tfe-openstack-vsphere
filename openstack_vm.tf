### Get image ID for latest version
data "openstack_images_image_v2" "Ubuntu1804" {
  name        = "Ubuntu1804-Latest"
  most_recent = true
}

### Deploy Ubuntu1804 with only provider network ###

resource "openstack_compute_instance_v2" "openstack-Ubuntu1804" {
  name        = "openstack-Ubuntu1804"
  flavor_name = "m4.small"
  key_pair    = "${var.OS_KEYPAIR}"

  lifecycle {
    ignore_changes = "block_device"
  }

  block_device {
    uuid                  = "${data.openstack_images_image_v2.Ubuntu1804.id}"
    source_type           = "image"
    volume_size           = "${data.openstack_images_image_v2.Ubuntu1804.min_disk_gb}"
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
  }

  network {
    name = "${var.OPENSTACK_PROVIDER_NET}"
  }
}

output "OpenStack-Ubuntu1804" {
  value = "${openstack_compute_instance_v2.openstack-Ubuntu1804.access_ip_v4}"
}
