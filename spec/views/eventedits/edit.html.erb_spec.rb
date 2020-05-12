require 'rails_helper'

RSpec.describe "eventedits/edit", type: :view do
  before(:each) do
    @eventedit = assign(:eventedit, Eventedit.create!())
  end

  it "renders the edit eventedit form" do
    render

    assert_select "form[action=?][method=?]", eventedit_path(@eventedit), "post" do
    end
  end
end
