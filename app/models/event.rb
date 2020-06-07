require 'koala'

class Event < ApplicationRecord
  has_one :eventedit

  acts_as_taggable_on :places

  $places = self.distinct.pluck(:city).filter{|p| p!=nil&&p!=""&&p!="City"}
  $categories = self.distinct.pluck(:category).filter{|c| c!=nil&&c!=""&&c!="Category"}
  $editCategories = Eventedit.distinct.pluck(:category).filter{|c| c!=nil&&c!=""&&c!="Category"}

  $menuCategories = $categories.push($editCategories).flatten.uniq

  $start_months = self.distinct.pluck(:start_time)
      .map{|x| Date.parse(x).month}.uniq.sort
      .filter{|month| month!=nil&&month!=""}
      .map{|x| Date::MONTHNAMES[x] }
  $start_years = self.distinct.pluck(:start_time)
      .map{|y| Date.parse(y).year}.uniq.sort
      .filter{|year| year!=nil&&year!=""}


  def self.synch_event(event, picture)
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
        # links
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
    existing_event = self.find_by(fbid: event['id'])
    if(picture!=nil && picture['data']!=nil)
      image = picture['data']['url']
    else
      image = ''
    end
    escaped_name = Regexp.escape(event['name'])
    if escaped_name.include? "Talk"
      category = "Talk"
    elsif escaped_name.include? "Meeting"
      category = "Meeting"
    elsif escaped_name.include? "March"
      category = "March"
    elsif escaped_name.include? "Workshop"
      category = "Workshop"
    else
      category = "Other"
    end
    if existing_event!=nil
      existing_event.update(
          fbid: event['id'],
          title: event['name'],
          image: image,
          start_time: event['start_time'],
          end_time: event['end_time'],
          description: event['description'],
          place_name: place_name,
          lat: lat,
          long: long,
          street: street,
          city: city,
          zip: zip,
          category: category

      )
    else
      self.create(
          fbid: event['id'],
          title: event['name'],
          image: image,
          start_time: event['start_time'],
          end_time: event['end_time'],
          description: event['description'],
          place_name: place_name,
          lat: lat,
          long: long,
          street: street,
          city: city,
          zip: zip,
          category: category
      )
    end
  end



end
