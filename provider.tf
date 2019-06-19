provider "google" {
  credentials = "${file("service-account.json")}"
  project = "mapan-243606"
  region = "us-central1"
  zone = "us-central1-c"
}