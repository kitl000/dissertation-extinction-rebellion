require 'rails_helper'

RSpec.describe "events/index", type: :view do
  before(:each) do
    assign(:events, [
      Event.create!(
        :title => "Title",
        :image => "Image",
        :start_time => "Start Time",
        :end_time => "End Time",
        :deescription => "Deescription",
        :place_name => "Place Name",
        :lat => "9.99",
        :long => "9.99",
        :street => "Street",
        :zip => "Zip"
      ),
      Event.create!(
        :title => "Title",
        :image => "Image",
        :start_time => "Start Time",
        :end_time => "End Time",
        :deescription => "Deescription",
        :place_name => "Place Name",
        :lat => "9.99",
        :long => "9.99",
        :street => "Street",
        :zip => "Zip"
      )
    ])
  end

  it "renders a list of events" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
    assert_select "tr>td", :text => "Start Time".to_s, :count => 2
    assert_select "tr>td", :text => "End Time".to_s, :count => 2
    assert_select "tr>td", :text => "Deescription".to_s, :count => 2
    assert_select "tr>td", :text => "Place Name".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Street".to_s, :count => 2
    assert_select "tr>td", :text => "Zip".to_s, :count => 2
  end
end
