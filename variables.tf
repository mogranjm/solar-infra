variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "region" {
  type        = string
  description = "GCP Region"
}

# variable "GOODWE_USER" {
#   type        = string
#   description = "GoodWe SEMS Portal Username"
# }

# variable "GOODWE_STATION_ID" {
#   type        = string
#   description = "GoodWe API Solar Array ID"
# }

variable "GCS_BUCKET_NAME" {
  type        = string
  description = "Destination Bucket for solar data"

}