class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]
  before_action :validate_admin, only: %i[ new create edit update destroy export_csv]
  def index
    if params[:category].present? && Event.categories.key?(params[:category])
      selected_category = params[:category]
      case selected_category
      when "entertainment"
        @events = Event.entertainment
      when "dining"
        @events = Event.dining
      when "business"
        @events = Event.business
      when "sports"
        @events = Event.sports
      when "education"
        @events = Event.education
      end
    else
      @events = Event.active
    end
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to events_path
    else
      render :edit, status: :uprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path
  end

  def export_csv
    csv_data = Event.generate_csv
    respond_to do |format|
      format.csv { send_data csv_data, filename: "events-#{Date.today}.csv" }
    end
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.expect(event: [ :title, :description, :date, :location, :time, :category, :photo ])
    end

    def validate_admin
      if Current.user&.regular?
        redirect_to events_path
      end
    end
end
