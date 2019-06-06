class HomesController < ApplicationController
  before_action :set_user, only: [:user_detail]
  before_action :check_crawl, only: [:crawl, :execute_crawl]

  def index
    @pagy, @users = pagy(User.sort_user(params).get_cameos)
  end

  def celebvm
    @pagy, @users = pagy(User.sort_user(params).where(type_web: "celebvm"))
  end

  def crawl
    @status = @status.present? ? @status : StatusCrawl.create({current_status: "new"})
  end

  def execute_crawl
    if @status.current_status == "running"
      redirect_to crawl_path, notice: "There is a crawl running, please waiting for a moment"
    else
      if params["type"] == "cameo"
        CameoJobJob.perform_later
      else
        CelebvmServices.new.execute
      end
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
    @status = StatusCrawl.last
  end
end
