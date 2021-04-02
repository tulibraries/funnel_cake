# frozen_string_literal: true

class FunnelCake::ConstraintsComponent < Blacklight::ConstraintsComponent
  # Overriden to handle missing facet constraint
  def facet_item_presenters
    return to_enum(:facet_item_presenters) unless block_given?

    Deprecation.silence(Blacklight::SearchState) do
      @search_state.filters.map do |facet|
        missing_facet = @search_state.params.dig("f", "-#{facet.key}:").present?
        facet.values.map do |val|
          next if val.blank? && !missing_facet

          if missing_facet && val.blank?
            yield facet_item_presenter(facet.config, "[Missing]", facet.key)
          elsif val.is_a?(Array)
            yield inclusive_facet_item_presenter(facet.config, val, facet.key) if val.any?(&:present?)
          else
            yield facet_item_presenter(facet.config, val, facet.key)
          end
        end
      end
    end
  end
end
