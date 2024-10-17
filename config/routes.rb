# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'

Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore,
                 key: '_interslice_session'

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  if Rails.env.production?
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      ActiveSupport::SecurityUtils.secure_compare(
        Digest::SHA256.hexdigest(username),
        Digest::SHA256.hexdigest(ENV.fetch('SIDEKIQ_USERNAME', nil))
      ) &
        ActiveSupport::SecurityUtils.secure_compare(
          Digest::SHA256.hexdigest(password),
          Digest::SHA256.hexdigest(ENV.fetch('SIDEKIQ_PASSWORD', nil))
        )
    end
  end

  mount Sidekiq::Web, at: 'queue'
end
