class HomesController < ApplicationController
  before_action :set_user, only: [:user_detail]
  before_action :check_crawl, only: [:crawl, :execute_crawl]

  def index
    @pagy, @users = pagy(User.sort_user(params).get_cameos)
  end

  def celebvm
    @pagy, @users = pagy(User.sort_user(params).get_celebvms)
  end

  def crawl
    if !@statuses.present?
      StatusCrawl.create(current_status: "new", name: "cameo")
      StatusCrawl.create(current_status: "new", name: "celebvm")
      @statuses = StatusCrawl.all
    end
  end

  def execute_crawl
    status = @statuses.find_by(name: params["type"])
    if status.present? && status.current_status == "running"
      return redirect_to root_path, notice: "There is a crawl #{@status.name} running, please waiting for a moment"
    end

    if params["type"] == "cameo"
      status.update({current_status: "running", name: params["type"]})
      CameoJobJob.perform_later
    else
      status.update({current_status: "running", name: params["type"]})
      CelebvmJobJob.perform_later
    end

    respond_to do |format|
      format.js
    end
  end

  def category_detail
    @category = Category.find_by(id: params[:id])
    @pagy, @users = pagy(@category.users)
  end

  def category_celebvm_detail
    @category = Category.find_by(id: params[:id])
    @pagy, @users = pagy(@category.users)
  end

  def user_detail; end

  def user_celebvm_detail
    @user = User.find_by(id: params["id"])
  end

  def back
    redirect_back(fallback_location: root_path)
  end

  def category
    @pagy, @categories = pagy(Category.all.includes(:users).get_cameos)
  end

  def category_celebvm
    @pagy, @categories = pagy(Category.all.includes(:users).get_celebvms)
  end

  private
  def set_user
    @user = User.find_by(_id: params["id"])
  end

  def check_crawl
    @statuses = StatusCrawl.all
  end
end
