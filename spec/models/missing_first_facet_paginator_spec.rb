# frozen_string_literal: true

require "rails_helper"

RSpec.describe MissingFirstFacetPaginator do
  def facet_item(value, hits, missing: false)
    Blacklight::Solr::Response::Facets::FacetItem.new(value: value, hits: hits, missing: missing)
  end

  let(:missing) { facet_item(nil, 3, missing: true) }
  let(:values) { %w[Alpha Beta Gamma].each_with_index.map { |v, i| facet_item(v, 10 - i) } }

  # Solr appends the missing bucket after the page of values it returns.
  let(:solr_page) { values + [missing] }

  describe "on the first page" do
    it "shows the missing value first even when the page of values is full" do
      paginator = described_class.new(solr_page, limit: 3, offset: 0, sort: "count")
      expect(paginator.items.first).to eq(missing)
    end

    it "does not drop a value to make room for it" do
      paginator = described_class.new(solr_page, limit: 3, offset: 0, sort: "count")
      expect(paginator.items.drop(1).map(&:value)).to eq(%w[Alpha Beta Gamma])
    end

    it "pins it when the facet is sorted alphabetically" do
      paginator = described_class.new([missing] + values, limit: 3, offset: 0, sort: "index")
      expect(paginator.items.first).to eq(missing)
    end

    it "leaves facets without a missing value alone" do
      paginator = described_class.new(values, limit: 3, offset: 0, sort: "count")
      expect(paginator.items.map(&:value)).to eq(%w[Alpha Beta Gamma])
    end

    it "suppresses the missing value when its hit count is zero" do
      zero_missing = facet_item(nil, 0, missing: true)
      paginator = described_class.new(values + [zero_missing], limit: 3, offset: 0, sort: "count")

      expect(paginator.items.map(&:value)).to eq(%w[Alpha Beta Gamma])
    end
  end

  describe "on a later page" do
    it "does not repeat the missing value" do
      paginator = described_class.new(solr_page, limit: 3, offset: 3, sort: "count")
      expect(paginator.items).not_to include(missing)
    end
  end

  describe "#total_count" do
    it "ignores the missing value so it cannot imply another page" do
      paginator = described_class.new(solr_page, limit: 3, offset: 0, sort: "count")
      expect(paginator.total_count).to eq(3)
      expect(paginator).to be_last_page
    end
  end
end
