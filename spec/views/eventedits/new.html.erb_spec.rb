require 'rails_helper'

RSpec.describe "eventedits/new", type: :view do
  before(:each) do
    assign(:eventedit, Eventedit.new())
  end

  it "renders new eventedit form" do
    render

    assert_select "form[action=?][method=?]", eventedits_path, "post" do
    end
  end
end
