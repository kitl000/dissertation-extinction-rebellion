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
  picture = @graph.get_connections(page['id'],'picture')
  puts picture.inspect
  events.each do |event|
    Event.create(
        title: event['name'],
        image: picture['data'].url,
        start_time: event['start_time'],
        end_time: event['end_time'],
        description: event['description'],
        lat: event['location']['latitude'],
        long: event['location']['longitude'],
        street: event['location']['street'],
        zip: event['location']['zip']
    )
  end
end
