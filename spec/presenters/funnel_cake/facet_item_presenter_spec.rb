# frozen_string_literal: true

require "rails_helper"

RSpec.describe FunnelCake::FacetItemPresenter, type: :presenter do
  subject(:presenter) do
    described_class.new(facet_item, facet_config, view_context, facet_field, search_state)
  end

  let(:facet_item) { instance_double(Blacklight::Solr::Response::Facets::FacetItem) }
  let(:facet_config) { Blacklight::Configuration::FacetField.new(key: "key") }
  let(:facet_field) { instance_double(Blacklight::Solr::Response::Facets::FacetField) }
  let(:view_context) { controller.view_context }
  let(:search_state) { instance_double(FunnelCake::SearchState) }
  let(:controller) { CatalogController.new }
  let(:config) { controller.blacklight_config }

  describe "#selected?" do
    context "with missing facet field but no missing facet param" do
      let(:search_state) { FunnelCake::SearchState.new({}, config) }
      it "works" do
        allow(presenter).to receive(:missing_facet?).and_return(true)
        allow(search_state).to receive(:has_facet?).and_return(true)
        expect(presenter.selected?).to be false
      end
    end

    context "with missing facet field and missing facet param" do
      let(:search_state) { FunnelCake::SearchState.new({ f: { "-key:" => [""] } }, config) }
      it "works" do
        allow(presenter).to receive(:missing_facet?).and_return(true)
        allow(search_state).to receive(:has_facet?).and_return(true)
        expect(presenter.selected?).to be true
      end
    end
  end
end
