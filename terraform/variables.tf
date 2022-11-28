variable "project_id" {
  description = "the gcp project id"
}

variable "instance_id" {
  description = "the cloud spanner instance id"
  default     = "my-instance"
}

variable "instance_config" {
  description = "the cloud spanner instance config"
  default     = "regional-us-central1"
}

variable "instance_processing_units" {
  description = "the cloud spanner instance processing units"
  default     = 100
}

variable "database_id" {
  description = "the cloud spanner database id"
  default     = "my-database"
}

variable "credentials_file" {
  description = "service account json file"
}

variable "region" {
  default     = "us-central1"
  description = "compute region"
}

variable "zone" {
  default     = "us-central1-c"
  description = "compute zone"
}

variable "gke_cluster_name" {
  default     = "my-cluster"
  description = "the name of the GKE cluster"
}

variable "gke_num_nodes" {
  default     = 1
  description = "number of nodes in the GKE cluster"
}

variable "iam_service_account_id" {
  description = "The IAM service account that will be granted Cloud Spanner permissions and bing to the kubernetes service account. This account will be created."
}

variable "k8s_service_account_id" {
  description = "The kubernetes service account that will impersonate the IAM service account to access Cloud Spanner. This account will be created."
}
