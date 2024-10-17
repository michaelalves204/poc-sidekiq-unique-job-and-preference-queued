# frozen_string_literal: true

sidekiq_redis_config = SidekiqPoc.redis_config

Sidekiq.configure_server do |config|
  config.redis = sidekiq_redis_config

  config.client_middleware do |chain|
    chain.add SidekiqUniqueJobs::Middleware::Client
  end

  config.server_middleware do |chain|
    chain.add SidekiqUniqueJobs::Middleware::Server
  end

  SidekiqUniqueJobs::Server.configure(config)

  config.on(:startup) do
    schedule_file = 'config/schedule.yml'

    if File.exist?(schedule_file)
      schedule = YAML.load_file(schedule_file)
      Sidekiq::Cron::Job.load_from_hash!(schedule)
    end
  end
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_redis_config

  config.client_middleware do |chain|
    chain.add SidekiqUniqueJobs::Middleware::Client
  end
end
