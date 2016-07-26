require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FileProjectS3
  class Application < Rails::Application

    Aws.config.update({
      region: 'us-east-1',
      credentials: Aws::Credentials.new('AKIAJNMD3L6U6MSHPTVA', 'zM+eE8qbgIMSd4WQaLJlT3gTIum0GHO97dkTZWk8')
    })

  end
end
