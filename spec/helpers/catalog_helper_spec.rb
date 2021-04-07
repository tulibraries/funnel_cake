# frozen_string_literal: true

require "rails_helper"


RSpec.describe CatalogHelper, type: :helper do
  describe "#facet_item_presenter" do

    it "returns a FunnelCake::FacetItemPresenter" do
      expect(helper.facet_item_presenter({}, "foo", "bar").class).to eq(FunnelCake::FacetItemPresenter)
    end
  end
end

public
  def search_state
  end
