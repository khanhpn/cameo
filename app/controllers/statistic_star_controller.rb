class StatisticStarController < ApplicationController
  def index
    @start_time = Date.today.beginning_of_week
    @end_time = Date.today.end_of_week
    @pagy, @categories = pagy(Category.all.includes(:users).search(@start_time, @end_time))
  end

  def search
    datetime = params["date_range"].split("-").map(&:squish).map(&:to_datetime)
    @start_time = datetime.dig(0)
    @end_time = datetime.dig(1)
    @pagy, @categories = pagy(Category.all.includes(:users).search(@start_time, @end_time))
  end
end
