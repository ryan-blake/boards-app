require 'sidekiq/web'

Sidekiq.configure_server do |config|
  ActiveRecord::Base.configurations[Rails.env.to_s]['pool'] = 30
end

if Rails.env.production?

   Sidekiq.configure_server do |config|
   config.redis = { url: ENV["REDISTOGO_URL"]}
   schedule_file = "config/schedule.yml"
   if File.exists?(schedule_file)
     Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
   end
  end

  Sidekiq.configure_client do |config|
   config.redis = { url: ENV["REDISTOGO_URL"]}
  end
end
