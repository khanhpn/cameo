class CameoJobJob < ApplicationJob
  queue_as :default
  after_perform :notification_to_user

  def perform(*args)
    cameo = CameoServices.new
    cameo.execute
  end

  private
  def notification_to_user
    status = StatusCrawl.last
    if status
      status.update({current_status: "finish"})
    else
      StatusCrawl.create({current_status: "finish"})
    end
  end

end
