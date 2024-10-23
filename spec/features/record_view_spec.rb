# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Record View" do
  it "displays a 'Staff View' link" do
    VCR.use_cassette("record_view", match_requests_on: [:query]) do
      visit solr_document_path("padig:PMA-JGJ_B015_F001_001")
      expect(page).to have_text "Staff View"
    end
  end
end
