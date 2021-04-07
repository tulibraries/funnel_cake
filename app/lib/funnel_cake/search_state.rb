# frozen_string_literal: true

module FunnelCake
  class SearchState < ::Blacklight::SearchState
    # Overridden in order to override FilterField class
    def filter(field_key_or_field)
      field = field_key_or_field if field_key_or_field.is_a? Blacklight::Configuration::Field
      field ||= blacklight_config.facet_fields[field_key_or_field]
      field ||= Blacklight::Configuration::NullField.new(key: field_key_or_field)
      (field.filter_class || FunnelCake::SearchState::FilterFieldOverride).new(field, self)
    end
  end
end
