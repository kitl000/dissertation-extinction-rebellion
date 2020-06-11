require 'rails_helper'

RSpec.describe Eventedit, type: :model do
  subject {
    described_class.new(title: "Anything",
                        description: "Lorem ipsum",
                        start_time: DateTime.now,
                        end_time: DateTime.now + 1.week)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a description" do
    subject.description = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a start_time" do
    subject.start_time = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a end_time" do
    subject.end_time = nil
    expect(subject).to_not be_valid
  end

end
