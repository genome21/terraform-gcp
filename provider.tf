provider "google" {
  credentials = "${file("service-account.json")}"
  project = "rowilkins-test1"
  region = "us-central1"
  zone = "us-central1-c"
}
