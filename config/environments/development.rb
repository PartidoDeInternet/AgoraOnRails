AgoraOnRails::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false
  config.eager_load    = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  # config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false
  
  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  config.action_mailer.default_url_options = { :host => 'agoraonrails.dev' }

  # Enable assets
  config.assets.enabled = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = true

  # Compress JavaScripts and CSS
  config.assets.compress = false
  
  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = true
  
  # Generate digests for assets URLs
  config.assets.digest = false

  # Expands the lines which load the assets
  config.assets.debug = false
end

