require 'rails_helper'

RSpec.describe "eventedits/index", type: :view do
  before(:each) do
    assign(:eventedits, [
      Eventedit.create!(),
      Eventedit.create!()
    ])
  end

  it "renders a list of eventedits" do
    render
  end
end
