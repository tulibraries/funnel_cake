# frozen_string_literal: true

module CatalogHelper
  include Blacklight::CatalogHelperBehavior

  def facet_item_presenter(facet_config, facet_item, facet_field)
    FunnelCake::FacetItemPresenter.new(facet_item, facet_config, self, facet_field)
  end
end
