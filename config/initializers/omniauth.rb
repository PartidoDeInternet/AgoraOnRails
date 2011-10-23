Rails.application.config.middleware.use OmniAuth::Builder do
  if ENV['TWITTER_CONSUMER_KEY'].blank? or ENV['TWITTER_CONSUMER_SECRET'].blank?
    warn "*" * 80
    warn "WARNING: Missing consumer key or secret. First, register an app with Twitter at"
    warn "https://dev.twitter.com/apps to obtain OAuth credentials. Then, start the server"
    warn "with the command: TWITTER_CONSUMER_KEY=abc TWITTER_CONSUMER_SECRET=123 rails server"
    warn "*" * 80
  end
  use OmniAuth::Strategies::Twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET']
end
