resource "google_compute_instance" "cos" {
    name = "cos"
    machine_type = "g1-small"

    boot_disk {
        initialize_params {
            image = "cos-cloud/cos-stable"
        }
    }

    metadata = {
        ssh-keys = "fadhlan:${file("~/.ssh/id_rsa.pub")}"
    }

    network_interface {
        network = "default"
        access_config {
            
        }
    }
    connection {
        host = "${google_compute_instance.cos.network_interface.0.access_config.0.nat_ip}"
        type = "ssh"
        user = "fadhlan"
        agent = false
        private_key = "${file("~/.ssh/id_rsa")}"
        timeout = "30s"
    }

    provisioner "file" {
        content = "${file("docker-compose.yml")}"
        destination = "~/docker-compose.yml"
    }

    provisioner "remote-exec"{
        inline = [
            "docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v $PWD:$PWD -w=$PWD docker/compose:1.24.0 up -d"
        ]
    }
}

resource "google_compute_firewall" "default" {
  name    = "cos-firewall"
  network = "default"
 
  allow {
    protocol = "tcp"
    ports    = ["8001"]
  }
 
  allow {
    protocol = "icmp"
  }
} 