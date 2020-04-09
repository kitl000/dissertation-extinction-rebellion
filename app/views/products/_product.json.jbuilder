json.extract! product, :id, :name, :description, :location, :date, :created_at, :updated_at
json.url product_url(product, format: :json)
