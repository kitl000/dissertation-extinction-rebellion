require 'koala'
require 'database_cleaner'

class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  # load_and_authorize_resource

  #before_action :authenticate_user!
  helper_method :synch_all_events

  include Pagy::Backend

  # GET /events
  # GET /events.json
  def index
    @search = params["search"]
    if @search.present?
      @events = Event.where("title ILIKE ?", "%#{@search}%")
    else
      @events = Event.all
    end
    @city = params["city"]
    @category = params["category"]
    if @city.present?
      @events = @events.where("city ILIKE ?", @city)
    end
    if @category.present?
      @events = @events.where("category ILIKE ?", @category)
    end
      @pagy, @events = pagy(@events, page: params[:page], items: 9)
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  def synch_all_events
    DatabaseCleaner.clean_with(:truncation)
    @graph = Koala::Facebook::API.new('EAAInkjqsD4UBAGdYpyowdWFeauzzcnZC6ChN4RoU4zMW4JrpoCCsSO2VxtsadanLusG6zz2JUAqkOIfHaephOQEiAJeodc26jnDWBkUWHoIvpin92r2RDYWcXrqESC08IXa5ZAEhLIbjHkEtZCgdF29ZAp1QUfGsWzaPMDlSAgZDZD')
    pages = @graph.get_connections('me','accounts')

    pages.each do |page|
      events = @graph.get_connections(page['id'],'events')
      picture = @graph.get_connections(page['id'],'picture',{redirect:0})

      events.each do |event|
        if (event['place']!=nil)
          place = event['place']
          place_name = place['name']
          if (place['location']!=nil)
            location = place['location']
            lat = location['latitude']
            long = location['longitude']
            street = location['street']
            city = location['city']
            zip = location['zip']
          else
            lat = nil
            long = nil
            street = nil
            zip = nil
          end
        else
          place_name = nil
          lat = nil
          long = nil
          street = nil
          zip = nil
        end
        existing_event = Event.find_by(title: event['title'])
        if(picture['data']!=nil)
          image = picture['data']['url']
        else
          image = ''
        end
        if existing_event!=nil
         existing_event.update(
             title: event['name'],
             image: image,
             start_time: event['start_time'],
             end_time: event['end_time'],
             description: event['description'],
             place_name: place_name,
             lat: lat,
             long: long,
             street: street,
             city: city,
             zip: zip

         )
        else
          Event.create(
              id: event['id'],
              title: event['name'],
              image: image,
              start_time: event['start_time'],
              end_time: event['end_time'],
              description: event['description'],
              place_name: place_name,
              lat: lat,
              long: long,
              street: street,
              city: city,
              zip: zip
              )
        end

      end
     end
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :image, :start_time, :end_time, :description, :place_name, :lat, :long, :street, :zip)
    end
end
