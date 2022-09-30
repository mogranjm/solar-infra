# solar service account to run the cloud function
resource "google_service_account" "solar_service_account" {
  # terraform import google_service_account.solar_service_account projects/servian-u-practice/serviceAccounts/solar-service@servian-u-practice.iam.gserviceaccount.com
  account_id   = "solar-service"
  display_name = "solar-service"
}

# allow terraform-service to act as solar-service
resource "google_service_account_iam_member" "solar_service_account_user" {
  # terraform import google_service_account_iam_member.solar_service_account_user "projects/servian-u-practice/serviceAccounts/solar-service@servian-u-practice.iam.gserviceaccount.com roles/iam.serviceAccountUser serviceAccount:terraform-service@servian-u-practice.iam.gserviceaccount.com" 
  service_account_id = google_service_account.solar_service_account.id
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:terraform-service@${var.project_id}.iam.gserviceaccount.com"
}

resource "google_project_iam_binding" "solar_service_functions_permissions" {
  project = var.project_id
  role    = "roles/cloudfunctions.admin"
  members = [
    "serviceAccount:terraform-service@${var.project_id}.iam.gserviceaccount.com",
    "serviceAccount:${google_service_account.solar_service_account.email}"
  ]
}

resource "google_project_iam_binding" "solar_service_secrets_permissions" {
  project = var.project_id
  role    = "roles/secretmanager.secretAccessor"
  members = [
    "serviceAccount:${google_service_account.solar_service_account.email}"
  ]
}

resource "google_project_iam_binding" "solar_service_storage_permissions" {
  project = var.project_id
  role    = "roles/storage.admin"
  members = [
    "serviceAccount:${google_service_account.solar_service_account.email}"
  ]
}
