class HomeController < ApplicationController
  include Pagy::Backend

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
    @pagy, @events = pagy(Event.all, page: params[:page], items: 8)
  end
end
