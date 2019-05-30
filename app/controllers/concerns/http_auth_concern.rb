module HttpAuthConcern
  extend ActiveSupport::Concern
  included do
    before_action :http_authenticate
  end

  def http_authenticate
    return true unless Rails.env == 'production'
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials.auth[:username] && password == Rails.application.credentials.auth[:password]
    end
  end
end
