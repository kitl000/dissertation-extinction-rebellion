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
    @pagy, @events = pagy(Event.where('start_time >= ?', Date.today).order(:start_time),
                          page: params[:page], items: 8)
  end
end
