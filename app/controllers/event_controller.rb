require 'koala'

class EventController < ApplicationController

  def synch_all_events
    @graph = Koala::Facebook::API.new('EAAInkjqsD4UBAGdYpyowdWFeauzzcnZC6ChN4RoU4zMW4JrpoCCsSO2VxtsadanLusG6zz2JUAqkOIfHaephOQEiAJeodc26jnDWBkUWHoIvpin92r2RDYWcXrqESC08IXa5ZAEhLIbjHkEtZCgdF29ZAp1QUfGsWzaPMDlSAgZDZD')
    pages = @graph.get_connections('me','accounts')
    pages.each do |page|
      puts page['id']
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
        def create
          Event.create(
              title: event['name'],
              image: picture['data']['url'],
              start_time: event['start_time'],
              end_time: event['end_time'],
              description: event['description'],
              place_name: place_name,
              lat: lat,
              long: long,
              street: street,
              zip: zip
          )
        end
      end
    end

  end
end