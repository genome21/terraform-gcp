resource "google_compute_instance" "vm1-test" {
  name = "vm1-test"
  machine_type = "g1-small"
  metadata_startup_script = "${file("backend_script.sh")}"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-minimal-1804-lts"
    }
  }

  metadata = {
   ssh-keys = "fadhlan:${file("~/.ssh/id_rsa.pub")}"
  }


  network_interface {
    network = "default"
    access_config{

    }
  }
}

resource "google_compute_instance" "vm2-test" {
  name = "vm2-test"
  machine_type = "g1-small"
  metadata_startup_script = "${file("backend_script.sh")}"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-minimal-1804-lts"
    }
  }

  metadata = {
   ssh-keys = "fadhlan:${file("~/.ssh/id_rsa.pub")}"
  }


  network_interface {
    network = "default"
    access_config{

    }
  }
}

resource "google_compute_instance" "load-balancer" {
  name = "load-balancer"
  machine_type = "g1-small"
  depends_on = ["google_compute_instance.vm1-test", "google_compute_instance.vm2-test"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-minimal-1804-lts"
    }
  }

  metadata = {
   ssh-keys = "fadhlan:${file("~/.ssh/id_rsa.pub")}"
  }

  network_interface {
    network = "default"
    access_config{

    }
  }

  connection {
      host = "${google_compute_instance.load-balancer.network_interface.0.access_config.0.nat_ip}"
      type = "ssh"
      user = "fadhlan"
      agent = false
      private_key = "${file("~/.ssh/id_rsa")}"
      timeout = "30s"
  }

  provisioner "file" {
    content = "${data.template_file.nginx_conf.rendered}"
    destination = "~/default"
  }

  provisioner "remote-exec" {
    inline = [
      "sleep 5",
      "sudo apt-get -y update",
      "sudo apt-get -y install nginx",
      "sudo cp ~/default /etc/nginx/sites-available/default",
      "sudo systemctl restart nginx"
    ]
  }
}

resource "google_compute_firewall" "default" {
  name    = "nginx-firewall"
  network = "default"
 
  allow {
    protocol = "tcp"
    ports    = ["80","443"]
  }
 
  allow {
    protocol = "icmp"
  }
} 