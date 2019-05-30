class ApplicationController < ActionController::Base
  include HttpAuthConcern
  include Pagy::Backend
end
