#create project variable
variable "project" {
  default = "qwiklabs-gcp-03-e0068463750f"
}

#Create Firewall rule
resource "google_compute_firewall" "allow-http" {
  project       = var.project
  name          = "allow-http"
  network       = "default"
  source_tags   = ["public"]
  source_ranges = ["10.1.0.0/24"]

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
}

#Create compute Instance
resource "google_compute_instance" "default" {
  project      = var.project
  name         = "debian-vm"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  # Explicit dependency
  depends_on = [google_compute_firewall.allow-http]
}