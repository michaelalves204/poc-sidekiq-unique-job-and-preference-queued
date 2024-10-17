# frozen_string_literal: true

module SidekiqPoc
  def self.redis_config
    root_path = Rails.root.join('config/redis.yml')
    redis_config = YAML.load_file(root_path, aliases: true).fetch(Rails.env, {})

    {
      url: "redis://#{redis_config['host']}:#{redis_config['port']}/0"
    }
  end

  def self.redis
    @redis ||= ConnectionPool::Wrapper.new do
      Redis.new(**redis_config)
    end
  end
end
