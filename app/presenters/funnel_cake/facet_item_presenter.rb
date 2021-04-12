# frozen_string_literal: true

module FunnelCake
  class FacetItemPresenter < Blacklight::FacetItemPresenter
    def missing_facet?
      facet_field.match?(/^-.*:$/) ||
        (facet_item.match?(/^-.*:$/) rescue false) ||
        (facet_item.fq.match?(/^-.*:\[\* TO \*\]$/) rescue false)
    end

    # Overridden to handle missing_facet case.
    def selected?
      if missing_facet?
        return false if search_state.params.dig("f", "-#{key}:").blank?
      end
      super
    end
  end
end
