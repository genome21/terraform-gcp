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