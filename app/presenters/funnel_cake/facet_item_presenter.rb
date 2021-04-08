# frozen_string_literal: true

module FunnelCake
  class FacetItemPresenter < Blacklight::FacetItemPresenter
    def facet_missing?
      facet_item.fq.match?(/^-.*:\[\* TO \*\]$/) rescue false
    end

    def facet_missing_label
      view_context.blacklight_config.facet_missing_label rescue "[MISSING]"
    end

    # Overridden to handle facet_missing label.
    def label
      return facet_missing_label if facet_missing?
      super
    end

    # Overridden to handle facet_missing case.
    def selected?
      if facet_missing?
        return false if search_state.params.dig("f", "-#{key}:").blank?
      end
      super
    end
  end
end
