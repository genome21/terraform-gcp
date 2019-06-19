provider "google" {
  credentials = "${file("service-account.json")}"
  project = "mapan-243606"
  region = "us-central1"
  zone = "us-central1-c"
}


resource "google_compute_instance" "vm1-test" {
  name = "vm1-test-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

  metadata = {
   ssh-keys = "fadhlan:${file("~/.ssh/id_rsa.pub")}"
  }


  network_interface {
    network = "default"
    access_config {
      nat_ip = "${google_compute_address.static.address}"
    }
  }

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      port = 22
      host = "${google_compute_address.static.address}"
      user = "fadhlan"
      agent = "false"
      private_key = "${file("~/.ssh/id_rsa")}"
    }
    inline = [
      "sleep 25",
      "sudo apt-get -y update",
      "sudo apt-get -y install nginx",
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

resource "google_compute_address" "static" {
  name = "ipv4-address"
}
