# frozen_string_literal: true

module FunnelCake
  class SearchState::FilterFieldOverride < Blacklight::SearchState::FilterField
    # Overridden to add missing field query logic
    def remove(item)
      new_state = search_state.reset_search
      if item.respond_to?(:field) && item.field != key
        return new_state.filter(item.field).remove(item)
      end

      params = new_state.params

      param = :f
      value = as_url_parameter(item)
      param = :f_inclusive if value.is_a?(Array)

      # need to dup the facet values too,
      # if the values aren't dup'd, then the values
      # from the session will get remove in the show view...
      params[param] = (params[param] || {}).dup
      params[param][key] = (params[param][key] || []).dup

      collection = params[param][key]
      # collection should be an array, because we link to ?f[key][]=value,
      # however, Facebook (and maybe some other PHP tools) tranform that parameters
      # into ?f[key][0]=value, which Rails interprets as a Hash.
      if collection.is_a? Hash
        Deprecation.warn(self, "Normalizing parameters in FilterField#remove is deprecated")
        collection = collection.values
      end

      params[param][key] = collection - Array(value)
      params[param].delete(key) if params[param][key].empty?
      params.delete(param) if params[param].empty?

      # Handle missing field queries.
      if (item.respond_to?(:fq) && item.fq == "-#{key}:[* TO *]") ||
          item == "[Missing]"
        params[param].delete("-#{key}:")
        params[param].delete(key) if params[param][key] == [""]
      end

      new_state.reset(params)
    end
  end
end
