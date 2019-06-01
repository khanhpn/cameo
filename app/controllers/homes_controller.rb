class HomesController < ApplicationController
  before_action :set_user, only: [:user_detail]
  before_action :check_crawl, only: [:crawl, :execute_crawl]

  def index
    @pagy, @users = pagy(User.all.includes(:categories).sort_user(set_params_sort))
  end

  def crawl
    @status = @status.present? ? @status : StatusCrawl.create({current_status: "new"})
  end

  def search_user
    @pagy, @users = pagy(User.all.includes(:categories).search(params))
  end

  def execute_crawl
    if @status.current_status == "running"
      redirect_to crawl_path, notice: "There is a crawl running, please waiting for a moment"
    else
      CameoJobJob.perform_later
      @status.update({current_status: "running"})

      respond_to do |format|
        format.js
      end
    end
  end

  def category_detail
    @category = Category.find_by(id: params[:id])
    @pagy, @users = pagy(@category.users)
  end

  def user_detail; end

  def back
    redirect_back(fallback_location: root_path)
  end

  def category
    @pagy, @categories = pagy(Category.all.includes(:users))
  end

  private
  def set_user
    @user = User.find_by(_id: params["id"])
  end

  def check_crawl
    @status = StatusCrawl.last
  end

  def set_params_sort
    params["created_at"] = "desc" if !params["name"].present? && !params["numOfRatings"].present?
    params
  end
end
