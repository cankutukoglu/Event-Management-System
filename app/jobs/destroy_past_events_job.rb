class DestroyPastEventsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Event.past.destroy_all
  end
end
