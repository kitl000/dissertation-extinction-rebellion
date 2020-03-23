require 'rails_helper'

describe EventController do
  describe '.synch_all_events' do
    context "given a request to synch events" do
      it "updates events from Facebook" do
        sc = EventController.new()
        testArray = sc.synch_all_events()
        expect(testArray.find { |item| item[:id] }).to_not be_nil
      end
    end
  end
end