class CelebvmJobJob < ApplicationJob
  queue_as :default
  after_perform :notification_to_user

  def perform(*args)
    cameo = CelebvmServices.new
    cameo.execute
  end

  private
  def notification_to_user
    status = StatusCrawl.find_by(name: "celebvm")
    status.update({current_status: "finish"})
  end
end
