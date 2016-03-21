OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, ENV['FACEBOOK_API_KEY'], ENV['FACEBOOK_SECRET_KEY']
end