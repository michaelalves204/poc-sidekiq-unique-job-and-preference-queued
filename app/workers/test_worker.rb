# frozen_string_literal: true

class TestWorker
  include Sidekiq::Worker

  sidekiq_options queue: :default, lock: :until_executed

  def perform(message)
    sleep 60
    File.open('test_job_sidekiq.txt', 'a') do |file|
      file.puts message
    end
  end
end
