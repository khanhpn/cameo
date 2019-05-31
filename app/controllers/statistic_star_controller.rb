class StatisticStarController < ApplicationController
  def index
    @current_week = "#{Date.today.beginning_of_week.strftime('%Y/%m/%d')} - #{Date.today.end_of_week.strftime('%Y/%m/%d')}"
    # @pagy, @categories = pagy(Category.all.includes(:users).search(@current_week))
    @pagy, @categories = pagy(Category.all.includes(:users))
  end

  def search

  end
end
