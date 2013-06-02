OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  if ENV['TWITTER_CONSUMER_KEY'].blank? or ENV['TWITTER_CONSUMER_SECRET'].blank?
    warn "*" * 80
    warn "WARNING: Missing consumer key or secret."
    warn "*" * 80
  end

  provider :twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET']
end
