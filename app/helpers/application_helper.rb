module ApplicationHelper
  include Pagy::Frontend

  def datetime_range(start_week, end_week)
    "#{start_week.strftime('%Y/%m/%d')} - #{end_week.strftime('%Y/%m/%d')}"
  end
end
