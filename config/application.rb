require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module ELearningSystem
  class Application < Rails::Application

    config.time_zone = 'Minsk'

    config.active_record.raise_in_transactional_callbacks = true

    if Rails.env.test?
      ActiveJob::Base.queue_adapter = :inline
    else
      ActiveJob::Base.queue_adapter = :sidekiq
    end
  end
end
