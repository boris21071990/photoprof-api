class ViewsUpdateJob < ApplicationJob
  queue_as :default

  def perform(viewable, ip, view_date)
    ViewsUpdater.new(viewable, ip, view_date).call
  end
end
