# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
# Rails.application.initialize!

require File.expand_path('../application', __FILE__)
require File.expand_path('../rollbar', __FILE__)

notify = ->(e) do
  begin
    Rollbar.with_config(use_async: false) do
      Rollbar.error(e)
    end
  rescue
    Rails.logger.error "Synchronous Rollbar notification failed.  Sending async to preserve info"
    Rollbar.error(e)
  end
end

begin
  Rails.application.initialize!
rescue Exception => e
  notify.(e)
  raise
end