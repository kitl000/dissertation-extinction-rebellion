# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'koala'
require 'database_cleaner'

  DatabaseCleaner.clean_with(:truncation)

#groupids = CSV.read(Rails.root.join('db','XRGroups.csv'))

@graph = Koala::Facebook::API.new('EAAInkjqsD4UBAGdYpyowdWFeauzzcnZC6ChN4RoU4zMW4JrpoCCsSO2VxtsadanLusG6zz2JUAqkOIfHaephOQEiAJeodc26jnDWBkUWHoIvpin92r2RDYWcXrqESC08IXa5ZAEhLIbjHkEtZCgdF29ZAp1QUfGsWzaPMDlSAgZDZD')
# profile = @graph.get_object('me')
# puts profile.inspect
# Koala::Facebook::API.graph_call(/graph/give/me/data,[args],verb)
pages = @graph.get_connections('me','accounts')
#begin
#   groupids.each do |id|
#     puts id[0]
#     group = @graph.get_object(id[0])
#       rescue Koala::Facebook::APIError => error
#       puts 'error getting object: ' + error.fb_error_message
#     puts group.inspect
#   end
#end
pages.each do |page|
  #puts page['id']
  events = @graph.get_connections(page['id'],'events')
  picture = @graph.get_connections(page['id'],'picture',{redirect:0})

  events.each do |event|
    puts event
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
        city = nil
        zip = nil
      end
    else
      place_name = nil
      lat = nil
      long = nil
      street = nil
      city = nil
      zip = nil
    end
    existing_event = Event.find_by(id: event['id'])
    if existing_event!=nil
    existing_event.update(
        id: event['id'],
        title: event['name'],
        image: picture['data']['url'],
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
          image: picture['data']['url'],
          start_time: event['start_time'],
          end_time: event['end_time'],
          description: event['description'],
          place_name: place_name,
          lat: lat,
          long: long,
          street: street,
          city: city,
          zip: zip,
      )
    end
    end
  end

