require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Kleinodien
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # https://www.codementor.io/mohnishjadwani/how-to-setup-rspec-factory-bot-and-spring-for-a-rails-5-engine-qjdpthfb1
    config.generators do |generator|
      generator.factory_bot dir: 'spec/factories'
    end
  end
end
