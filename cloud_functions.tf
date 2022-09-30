resource "google_cloudfunctions_function" "get_current_solar_data" {
  name        = "get-current-solar-data"
  description = "Function to query GoodWe Solar API"
  runtime     = "python39"
  max_instances = 5
  min_instances = 0

  # don't forget to give terraform SA access to this SA via roles/iam.serviceAccountUser role
  service_account_email = "solar-service@${var.project_id}.iam.gserviceaccount.com"

  source_repository {
    url = "https://source.developers.google.com/projects/servian-u-practice/repos/solar-data-pipe/moveable-aliases/main/paths/"
  }

  entry_point = "get_current_solar_data"

  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource   = "projects/${var.project_id}/topics/${google_pubsub_topic.trigger_get_solar_data.name}"
    failure_policy {
      retry = false
    }
  }

  environment_variables = {
    # GOODWE_STATION_ID = var.GOODWE_STATION_ID
    # GOODWE_USER       = var.GOODWE_USER
    GCS_BUCKET_NAME   = var.GCS_BUCKET_NAME
  }

  secret_environment_variables {
    key        = "GOODWE_USER"
    secret     = "GOODWE_USER"
    project_id = "1054661108717"
    version    = 1
  }
  
  secret_environment_variables {
    key        = "GOODWE_PASSWORD"
    secret     = "GOODWE_PASSWORD"
    project_id = "1054661108717"
    version    = 1
  }

  secret_environment_variables {
    key        = "GOODWE_STATION_ID"
    secret     = "GOODWE_STATION_ID"
    project_id = "1054661108717"
    version    = 1
  }
}