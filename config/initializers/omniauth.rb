OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  if ENV['AGORAONRAILS_TWITTER_CONSUMER_KEY'].blank? or ENV['AGORAONRAILS_FACEBOOK_CONSUMER_KEY'].blank?
     warn "*" * 80
     warn "WARNING: Omnimauth missing environment variable."
     warn "*" * 80
  end

  provider :twitter,  ENV['AGORAONRAILS_TWITTER_CONSUMER_KEY'],  ENV['AGORAONRAILS_TWITTER_CONSUMER_SECRET']
  provider :facebook, ENV['AGORAONRAILS_FACEBOOK_CONSUMER_KEY'], ENV['AGORAONRAILS_FACEBOOK_CONSUMER_SECRET'], :display => 'popup'
end
