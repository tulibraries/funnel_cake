# frozen_string_literal: true

require "rails_helper"

RSpec.describe MissingFirstFacetPaginator do
  def facet_item(value, hits, missing: false)
    Blacklight::Solr::Response::Facets::FacetItem.new(value: value, hits: hits, missing: missing)
  end

  let(:missing) { facet_item(nil, 3, missing: true) }
  let(:values) { [facet_item("Alpha", 10), facet_item("Beta", 7), facet_item("Gamma", 1)] }

  it "pins the missing value to the top when sorted by count" do
    paginator = described_class.new(values.dup.insert(2, missing), sort: "count")
    expect(paginator.items.first).to eq(missing)
  end

  it "pins the missing value to the top when sorted alphabetically" do
    paginator = described_class.new(values.dup.push(missing), sort: "index")
    expect(paginator.items.first).to eq(missing)
  end

  it "keeps the order of the remaining values" do
    paginator = described_class.new(values.dup.insert(1, missing), sort: "count")
    expect(paginator.items.drop(1).map(&:value)).to eq(%w[Alpha Beta Gamma])
  end

  it "leaves facets without a missing value alone" do
    paginator = described_class.new(values, sort: "count")
    expect(paginator.items.map(&:value)).to eq(%w[Alpha Beta Gamma])
  end
end
