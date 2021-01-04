# frozen_string_literal: true

require "rails_helper"

RSpec.describe "CSV Controller", type: :request do

  let(:base_solr_url) { "127.0.0.1:8983/solr/blacklight-core-test/select" }

  it "responds with a csv" do
    page1 = stub_request(:any, base_solr_url)
     .with(query: hash_including({ "cursorMark" => "*" }))
     .to_return(body: File.new(file_fixture("cursorMark=page1.json")), status: 200)

    page2 = stub_request(:any, base_solr_url)
     .with(query: hash_including({ "cursorMark" => "page2" }))
     .to_return(body: File.new(file_fixture("cursorMark=page2.json")), status: 200)

    page3 = stub_request(:any, base_solr_url)
    .with(query: hash_including({ "cursorMark" => "page3" }))
    .to_return(body: File.new(file_fixture("cursorMark=page3.json")), status: 200)

    get "/csv", params: { action: "index", controller: "catalog", format: "csv" }
    expect(response.content_type).to eq("text/csv")


    expect(page1).to have_been_requested.once
    expect(page2).to have_been_requested.once
    expect(page3).to have_been_requested.once
    # Preview field from the last item in the last fixture file
    expect(response.body).to include("https://archive.org/details/LVRR_1866_Report,https://archive.org/services/img/LVRR_1866_Report")
  end
end
