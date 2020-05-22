class HomeController < ApplicationController
  include Pagy::Backend

  def load_events
    @events = Event.all.map(&method(:load_event_by_id));
    @events_default = Gmaps4rails.build_markers(@events) do |plot, marker|
      marker.lat plot.lat
      marker.lng plot.long
        marker.infowindow plot.title
    end
    return @events
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

  def index
    load_events
    @pagy, @events = pagy(Event.where('start_time >= ?', Date.today).order(:start_time),
                          page: params[:page], items: 8)
    @events = @events.map(&method(:load_event_by_id))
  end
end
