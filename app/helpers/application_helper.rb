module ApplicationHelper
  include Pagy::Frontend

  def datetime_range(start_week, end_week)
    return if !start_week.present? || !end_week.present?
    "#{start_week.strftime('%d/%m/%Y')} - #{end_week.strftime('%d/%m/%Y')}"
  end
end
