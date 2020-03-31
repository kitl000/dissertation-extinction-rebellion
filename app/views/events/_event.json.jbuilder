json.extract! event, :id, :title, :image, :start_time, :end_time, :deescription, :place_name, :lat, :long, :street, :zip, :created_at, :updated_at
json.url event_url(event, format: :json)
