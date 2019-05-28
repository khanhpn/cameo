class HomesController < ApplicationController
  def index
    @pagy, @users = pagy(User.all.includes(:category))
  end

  def crawl
    cameo = CameoServices.new
    cameo.execute
  end

  def category
    @pagy, @categories = pagy(Category.all)
  end
end
