resource "google_compute_instance" "vm1-test" {
  name = "vm1-test"
  machine_type = "g1-small"
  metadata_startup_script = "${file("scripts/backend_script.sh")}"

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
  metadata_startup_script = "${file("scripts/backend_script.sh")}"

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