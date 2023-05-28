require 'sidekiq/cron'

Sidekiq.configure_server do |config|
  config.on(:startup) do
    Sidekiq.schedule = YAML.load_file(File.expand_path('config/sidekiq_schedule.yml'))
    Sidekiq::Cron::Job.load_from_hash(Sidekiq.schedule)
  end
end