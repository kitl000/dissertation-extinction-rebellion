class HomeController < ApplicationController
  def load_events
    @events = Event.all
    @events_default = Gmaps4rails.build_markers(@events) do |plot, marker|
      events_path = view_context.link_to plot.title, events_path(plot)
      marker.lat plot.lat
      marker.lng plot.long
      marker.infowindow "<b>#{events_path}</b>"
    end
  end

  def index
    load_events
    @events = Event.order(:title)
  end
end
