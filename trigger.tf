resource "google_cloud_scheduler_job" "trigger_get_solar" {
  name        = "trigger-get-solar"
  description = "CRON Job to trigger the get_current_solar_data function"
  schedule    = "* 7-18 * * *"

  pubsub_target {
    topic_name = google_pubsub_topic.trigger_get_solar_data.id
    data       = base64encode("go")
  }
}

resource "google_pubsub_topic" "trigger_get_solar_data" {
  name = "trigger-get-solar-data"
}