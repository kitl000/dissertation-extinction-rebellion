class HomeController < ApplicationController
  def index
    @events = Event.order(:title)
  end
end
