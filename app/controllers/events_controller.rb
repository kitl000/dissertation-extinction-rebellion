require 'koala'
require 'database_cleaner'

class EventsController < ApplicationController
  # before_action :authenticate_user!
  before_action :authenticate_admin, only: [:destroy, :edit, :update]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # DatabaseCleaner.allow_production = true
  # DatabaseCleaner.allow_remote_database_url = true

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
    @start_month = params["start_month"]
    @start_year = params["start_year"]
    if @city.present?
      @events = @events.where("city ILIKE ?", @city)
    end
    if @category.present?
      @events = @events.where("category ILIKE ?", @category)
    end
    if @start_month.present?
      @index_month = Date::MONTHNAMES.index(@start_month)
      @start_date = DateTime.new(2020,@index_month)
      @end_of_start_date = DateTime.new(2020,@index_month).next_month(1)
      @events = @events.where("start_time BETWEEN '#{@start_date}' AND '#{@end_of_start_date}'", @start_month)
    end
    if @start_year.present?
      @start_year = DateTime.strptime(@start_year, '%Y')
      @end_of_start_year = @start_year.next_year(1)
      @events = @events.where("start_time BETWEEN '#{@start_year}' AND '#{@end_of_start_year}'", @start_year)
    end
      @pagy, @events = pagy(@events, page: params[:page], items: 8)
    @events = @events.map(&method(:load_event_by_id))
  end


  # GET /events/new
  def new
    @event = Event.new
  end

  def synch_all_events
    @graph = Koala::Facebook::API.new('EAAInkjqsD4UBAGdYpyowdWFeauzzcnZC6ChN4RoU4zMW4JrpoCCsSO2VxtsadanLusG6zz2JUAqkOIfHaephOQEiAJeodc26jnDWBkUWHoIvpin92r2RDYWcXrqESC08IXa5ZAEhLIbjHkEtZCgdF29ZAp1QUfGsWzaPMDlSAgZDZD')
    pages = @graph.get_connections('me','accounts')

    pages.each do |page|
      events = @graph.get_connections(page['id'],'events')
      picture = @graph.get_connections(page['id'],'picture',{redirect:0})

      events.each do |event|
        self.synch_event(event,picture)
      end
    end
    redirect_to events_path, notice: "Events Updated"
  end

  def synch_event_by_id
    @id = params["fbid"]
    @graph = Koala::Facebook::API.new('EAAInkjqsD4UBAGdYpyowdWFeauzzcnZC6ChN4RoU4zMW4JrpoCCsSO2VxtsadanLusG6zz2JUAqkOIfHaephOQEiAJeodc26jnDWBkUWHoIvpin92r2RDYWcXrqESC08IXa5ZAEhLIbjHkEtZCgdF29ZAp1QUfGsWzaPMDlSAgZDZD')
    event = @graph.get_object(@id)
    picture = @graph.get_connections(event['id'],'picture',{redirect:0})
    synch_event(event, picture[0])
  end

  def synch_event(event, picture)
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
        # links
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
    existing_event = Event.find_by(fbid: event['id'])
    if(picture!=nil && picture['data']!=nil)
      image = picture['data']['url']
    else
      image = ''
    end
    escaped_name = Regexp.escape(event['name'])
    if escaped_name.include? "Talk"
      category = "Talk"
    elsif escaped_name.include? "Meeting"
      category = "Meeting"
    elsif escaped_name.include? "March"
      category = "March"
    elsif escaped_name.include? "Workshop"
      category = "Workshop"
    else
      category = "Other"
    end
    if existing_event!=nil
      existing_event.update(
          fbid: event['id'],
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
          zip: zip,
          category: category

      )
    else
      Event.create(
          fbid: event['id'],
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
          zip: zip,
          category: category
      )
    end
  end

  # GET /events/1/edit
  def edit
    self.load_event_by_id(@event)
  end

  def show
    self.load_event_by_id(@event)
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
      @id = params["fbid"]
      @graph = Koala::Facebook::API.new('EAAInkjqsD4UBAGdYpyowdWFeauzzcnZC6ChN4RoU4zMW4JrpoCCsSO2VxtsadanLusG6zz2JUAqkOIfHaephOQEiAJeodc26jnDWBkUWHoIvpin92r2RDYWcXrqESC08IXa5ZAEhLIbjHkEtZCgdF29ZAp1QUfGsWzaPMDlSAgZDZD')
      event = @graph.get_object(@id)
      picture = @graph.get_connections(event['id'],'picture',{redirect:0})
      synch_event(event, picture[0])
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

  def load_event_by_id e
    @editedEvent = Eventedit.find_by_fbid(e.fbid)
    if(@editedEvent != nil)
      @editedEvent.attributes.each do |name, value|
        unless value == nil || value == ''
          e.write_attribute(name, value);
        end
      end
    end
    return e;
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:id, :fbid, :title, :image, :start_time, :end_time, :description, :lat, :long, :street, :zip, :city, :category)
    end
end

