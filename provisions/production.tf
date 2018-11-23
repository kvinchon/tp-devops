# Create Heroku apps for production
resource "heroku_app" "production" {
  name = "kvinchon-production"
  region = "us"
  buildpacks = [
    "heroku/go"
  ]
}

// # Couple app to different pipeline stages

resource "heroku_pipeline_coupling" "production" {
  app      = "${heroku_app.production.name}"
  pipeline = "${heroku_pipeline.devops-app.id}"
  stage    = "production"
}

# Create a database, and configure the app to use it
resource "heroku_addon" "production_database" {
  app  = "${heroku_app.production.name}"
  plan = "heroku-postgresql:hobby-dev"
}
