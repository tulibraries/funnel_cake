# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Record View" do
  it "displays a 'Staff View' link" do
    VCR.use_cassette("record_view", match_requests_on: [:query]) do
      visit solr_document_path("padig:PMA-JGJ_B015_F001_001")
      expect(page).to have_text("Staff View")
    end
  end

  it "displays search navigation controls once" do
    VCR.use_cassette("record_view_search_navigation", match_requests_on: [:query]) do
      visit root_path(q: "cat", search_field: "all_fields")

      first("article.document a").click

      expect(page).to have_text("Start Over", count: 1)
      expect(page).to have_text("Back to Search", count: 1)
    end
  end
end
