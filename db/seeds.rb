# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'koala'

@graph = Koala::Facebook::API.new('EAAInkjqsD4UBAGdYpyowdWFeauzzcnZC6ChN4RoU4zMW4JrpoCCsSO2VxtsadanLusG6zz2JUAqkOIfHaephOQEiAJeodc26jnDWBkUWHoIvpin92r2RDYWcXrqESC08IXa5ZAEhLIbjHkEtZCgdF29ZAp1QUfGsWzaPMDlSAgZDZD')
# profile = @graph.get_object('me')
# puts profile.inspect
# Koala::Facebook::API.graph_call(/graph/give/me/data,[args],verb)
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
