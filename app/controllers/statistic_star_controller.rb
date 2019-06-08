class StatisticStarController < ApplicationController
  before_action :set_params

  def index
    @type = params["type"] ? params["type"] : "cameo"
    @pagy, @categories = pagy(Category.all.includes(:users).search(@start_time, @end_time, @type))
  end

  private
  def set_params
    if params["date_range"].present?
      datetime = params["date_range"].split("-").map(&:squish).map(&:to_datetime)
      @start_time = datetime.dig(0)
      @end_time = datetime.dig(1)
    else
      @start_time = Date.today.beginning_of_week
      @end_time = Date.today.end_of_week
    end
  end
end
