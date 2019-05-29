class CameoJobJob < ApplicationJob
  queue_as :default

  rescue_from(ErrorLoadingSite) do
    retry_job wait: 5.minutes, queue: :low_priority
  end

  def perform(*args)
    cameo = CameoServices.new
    cameo.execute
  end
end
