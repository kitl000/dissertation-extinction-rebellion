class Event < ApplicationRecord

  acts_as_taggable_on :places

  $places = self.distinct.pluck(:city).filter{|p| p!=nil&&p!=""&&p!="City"}
end
