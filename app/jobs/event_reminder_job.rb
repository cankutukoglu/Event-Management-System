class EventReminderJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Event.tomorrow.includes(:users).find_each do |event|
      event.users.each do |user|
        EventMailer.with(event: self, user: user).is_soon(user, event).deliver_later
      end
    end
  end
end
