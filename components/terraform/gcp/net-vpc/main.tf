locals {
}

resource "google_compute_network" "vpc_network" {
  name                    = module.this.id
  auto_create_subnetworks = var.auto_create_subnetworks
  project                 = var.project_id
}

resource "google_compute_subnetwork" "subnet" {
  for_each = { for key, val in var.subnets : key => val }

  name          = "${module.this.id}-${each.value.name}"
  network       = google_compute_network.vpc_network.id
  ip_cidr_range = each.value["ip_cidr_range"]
  project       = var.project_id
  region        = var.region

  dynamic "secondary_ip_range" {
    for_each = each.value["secondary_ip_ranges"]

    content {
      range_name    = secondary_ip_range.value["range_name"]
      ip_cidr_range = secondary_ip_range.value["ip_cidr_range"]
    }
  }
}

