resource "google_container_cluster" "primary" {
  name     = var.gke_cluster_name
  location = var.zone

  initial_node_count = var.gke_num_nodes

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  ip_allocation_policy {}

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
}

resource "google_service_account" "app-service-account" {
  account_id = var.iam_service_account_id
  project    = var.project_id
}

resource "kubernetes_service_account" "k8s-service-account" {
  metadata {
    name      = var.k8s_service_account_id
    namespace = "default"
    annotations = {
      "iam.gke.io/gcp-service-account" : "${google_service_account.app-service-account.email}"
    }
  }
}

data "google_iam_policy" "spanner-policy" {
  binding {
    role = "roles/iam.workloadIdentityUser"
    members = [
      "serviceAccount:${var.project_id}.svc.id.goog[default/${kubernetes_service_account.k8s-service-account.metadata[0].name}]"
    ]
  }
}

resource "google_service_account_iam_policy" "app-service-account-iam" {
  service_account_id = google_service_account.app-service-account.name
  policy_data        = data.google_iam_policy.spanner-policy.policy_data
}

data "google_iam_policy" "database-reader-policy" {
  binding {
    role = "roles/spanner.databaseReader"
    members = [
      "serviceAccount:${google_service_account.app-service-account.email}"
    ]
  }
}

resource "google_spanner_database_iam_policy" "database" {
  instance    = google_spanner_instance.instance.name
  database    = google_spanner_database.database.name
  policy_data = data.google_iam_policy.database-reader-policy.policy_data
}
