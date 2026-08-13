# frozen_string_literal: true

require "rails_helper"

RSpec.describe CatalogController do
  describe "search field configuration" do
    it "includes Collection Name as a searchable field" do
      search_field = described_class.blacklight_config.search_fields["collection"]

      expect(search_field).to be_present
      expect(search_field.label).to eq("Collection Name")
    end

    it "uses the collection Solr query fields" do
      search_field = described_class.blacklight_config.search_fields["collection"]

      expect(search_field.solr_parameters).to include(
        qf: "${collection_qf}",
        pf: "${collection_pf}"
      )
    end
  end
end
