# frozen_string_literal: true

require "rails_helper"


RSpec.describe BlacklightHelper, type: :helper do
  describe "#record_page_links" do
    context "text[:value] is an array of multiple string values" do
      let(:text) { {
        value: [
          "https://media.philamuseum.org/image/JGJ_B001_F002_002_001/full/800,/0/default.jpg",
          "https://media.philamuseum.org/image/JGJ_B001_F002_002_002/full/800,/0/default.jpg"
        ]
        } }

      it "returns links for multiple items" do
        expect(helper.record_page_links(text)).to have_selector("a", count: 2)
      end
    end
  end
end
