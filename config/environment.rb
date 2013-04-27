# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
StoreEngine::Application.initialize!

ActionMailer::Base.smtp_settings = {
  address: "smtp.gmail.com",
  port: 587,
  domain: "dose-gates.herokuapp.com",
  authentication: "plain",
  enable_starttls_auto: true,
  user_name: "epic.sale.dose.gates@gmail.com",
  password: "dosegates"
}
