class StatisticStarController < ApplicationController
  def index
    @start_time = Date.today.beginning_of_week
    @end_time = Date.today.end_of_week
    @pagy, @categories = pagy(Category.all.includes(:users).search(@start_time, @end_time))
    # @pagy, @categories = pagy(Category.all.includes(:users))
  end

  def search
    @start_time = Date.today.beginning_of_week
    @end_time = Date.today.end_of_week
    @pagy, @categories = pagy(Category.all.includes(:users).search(@start_time, @end_time))
  end
end
