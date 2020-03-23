class Event < ActiveRecord::Base
  def self.search(search_term)
    Event.where("name ilike ?", "%#{search_term}%")
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
