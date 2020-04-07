require 'rails_helper'

RSpec.describe "events/new", type: :view do
  before(:each) do
    assign(:event, Event.new(
      :title => "MyString",
      :image => "MyString",
      :start_time => "MyString",
      :end_time => "MyString",
      :deescription => "MyString",
      :place_name => "MyString",
      :lat => "9.99",
      :long => "9.99",
      :street => "MyString",
      :zip => "MyString"
    ))
  end

  it "renders new event form" do
    render

    assert_select "form[action=?][method=?]", events_path, "post" do

      assert_select "input[name=?]", "event[title]"

      assert_select "input[name=?]", "event[image]"

      assert_select "input[name=?]", "event[start_time]"

      assert_select "input[name=?]", "event[end_time]"

      assert_select "input[name=?]", "event[deescription]"

      assert_select "input[name=?]", "event[place_name]"

      assert_select "input[name=?]", "event[lat]"

      assert_select "input[name=?]", "event[long]"

      assert_select "input[name=?]", "event[street]"

      assert_select "input[name=?]", "event[zip]"
    end
  end
end
