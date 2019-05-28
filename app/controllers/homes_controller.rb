class HomesController < ApplicationController
  before_action :set_user, only: [:user_detail]

  def index
    @pagy, @users = pagy(User.all.includes(:categories))
  end

  def crawl
    cameo = CameoServices.new
    cameo.execute
  end

  def user_detail; end

  def back
    redirect_back(fallback_location: root_path)
  end

  def category
    @pagy, @categories = pagy(Category.all)
  end

  private
  def set_user
    @user = User.find_by(_id: params["id"])
  end
end
