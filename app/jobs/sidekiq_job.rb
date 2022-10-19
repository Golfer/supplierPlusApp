class SidekiqJob
  include Sidekiq::Job
  sidekiq_options retry: false
end
