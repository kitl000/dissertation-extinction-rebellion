class HomeController < ApplicationController
  def load_events
    @events = Event.all
    @events_default = Gmaps4rails.build_markers(@events) do |plot, marker|
      marker.lat plot.lat
      marker.lng plot.long
    end
  end

  def index
    load_events
    @events = Event.order(:title)
  end
end
