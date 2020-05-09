class Event < ApplicationRecord

  acts_as_taggable_on :places

  $places = self.distinct.pluck(:city).filter{|p| p!=nil&&p!=""&&p!="City"}
  $categories = self.distinct.pluck(:category).filter{|c| c!=nil&&c!=""&&c!="Category"}
  $start_months = self.distinct.pluck(:start_time)
      .map{|x| Date.parse(x).month}.uniq.sort
      .filter{|month| month!=nil&&month!=""}
      .map{|x| Date::MONTHNAMES[x] }
  $start_years = self.distinct.pluck(:start_time)
      .map{|y| Date.parse(y).year}.uniq.sort
      .filter{|year| year!=nil&&year!=""}
end
