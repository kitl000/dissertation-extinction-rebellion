require 'rails_helper'

RSpec.describe "events/show", type: :view do
  before(:each) do
    @event = assign(:event, Event.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Image/)
    expect(rendered).to match(/Start Time/)
    expect(rendered).to match(/End Time/)
    expect(rendered).to match(/Deescription/)
    expect(rendered).to match(/Place Name/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Street/)
    expect(rendered).to match(/Zip/)
  end
end
