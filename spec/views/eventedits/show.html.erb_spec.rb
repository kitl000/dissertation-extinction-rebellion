require 'rails_helper'

RSpec.describe "eventedits/show", type: :view do
  before(:each) do
    @eventedit = assign(:eventedit, Eventedit.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
