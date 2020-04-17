class Event < ApplicationRecord
  def self.find_term(q)
    events = all
    events = events.where("events.title LIKE ?", "%#{q}%")
  end
  end
