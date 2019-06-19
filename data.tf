data "template_file" "nginx_conf" {
  template = "${file("default")}"

  vars = {
    web1_ip = "${google_compute_instance.vm1-test.network_interface.0.network_ip}"
    web2_ip = "${google_compute_instance.vm2-test.network_interface.0.network_ip}"
  }
}