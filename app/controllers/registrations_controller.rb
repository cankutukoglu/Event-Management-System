class RegistrationsController < ApplicationController
  before_action :set_event, only: [ :create ]
  before_action :set_reg, only: [ :destroy ]
  before_action :validate_regular
  def index
    @registrations = Current.user.registrations
  end

  def destroy
    validate_same_user
    @event = @registration.event
    @registration.destroy
    redirect_to @event
  end

  def create
    validate_has_reg
    @registration = Registration.new(user: Current.user, event: @event)
    if @registration.save!
      redirect_to @event
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_reg
    @registration = Registration.find(params[:id])
  end

  def validate_regular
    if Current.user&.admin?
      redirect_to events_path
    end
  end

  def validate_has_reg
    if Current.user.events.include?(@event)
      redirect_to events_path
    end
  end

  def validate_same_user
    if @registration.user != Current.user
      redirect_to events_path
    end
  end
end
