class EventMailer < ApplicationMailer
  def is_soon
    @event = params[:event]
    mail to: params[:user].email_address
  end
end
