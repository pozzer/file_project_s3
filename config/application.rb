require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FileProjectS3
  class Application < Rails::Application

    Aws.config.update({
      region: 'us-east-1',
      credentials: Aws::Credentials.new('AKIAIINULSJCBNLPUA7A', 'eHUZihH3KezvjcjLx0cfqOxL3B60Zqrw9lYZZ172'),
      #:s3 => { :region => 'us-east-2' }
    })
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
