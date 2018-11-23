# Configure the Heroku provider
provider "heroku" {
  email   = "${var.heroku_email}"
  api_key = "${var.heroku_api_key}"
}

variable "heroku_email" {
    type = "string"
}
variable "heroku_api_key" {
    type = "string"
}

# Create Heroku apps for staging and production
resource "heroku_app" "staging" {
  name = "kvinchon-staging"
  region = "us"
  buildpacks = [
    "heroku/go"
  ]
}
resource "heroku_app" "production" {
  name = "kvinchon-production"
  region = "us"
  buildpacks = [
    "heroku/go"
  ]
}

// # Create a Heroku pipeline
resource "heroku_pipeline" "devops-app" {
  name = "devops-app"
}

// # Couple apps to different pipeline stages
resource "heroku_pipeline_coupling" "staging" {
  app      = "${heroku_app.staging.name}"
  pipeline = "${heroku_pipeline.devops-app.id}"
  stage    = "staging"
}

resource "heroku_pipeline_coupling" "production" {
  app      = "${heroku_app.production.name}"
  pipeline = "${heroku_pipeline.devops-app.id}"
  stage    = "production"
}

# Create a database, and configure the app to use it
resource "heroku_addon" "database" {
  app  = "${heroku_app.staging.name}"
  plan = "heroku-postgresql:hobby-dev"
}
