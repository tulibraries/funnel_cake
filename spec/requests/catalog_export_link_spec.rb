# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Catalog export link", type: :request do
  let(:base_solr_url) { "127.0.0.1:8983/solr/blacklight-core-test/select" }

  it "renders the csv export link on the search results page" do
    stub_request(:any, base_solr_url)
      .with(query: hash_including({}))
      .to_return(body: File.new(file_fixture("cursorMark=page1.json")), status: 200)

    get "/catalog", params: { q: "test", sort: "date_si desc" }

    expect(response).to have_http_status(:ok)
    link = response.body[/href="\/csv\?[^"]*"/]
    expect(link).to include("format=csv", "q=test", "sort=date_si")
  end
end
