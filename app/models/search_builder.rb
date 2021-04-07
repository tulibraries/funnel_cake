# frozen_string_literal: true

class SearchBuilder < Blacklight::SearchBuilder
  include Blacklight::Solr::SearchBuilderBehavior

  self.default_processor_chain += [:add_missing_field_query]

  # Build and append a missing field query.
  def add_missing_field_query(solr_parameters)
    return unless solr_parameters["facet.missing"]

    solr_parameters[:fq].append(*(blacklight_params["f"] || [])
      .select { |f| f.match(/^-/) }
      .map { |k, v| "#{k}[* TO *]" })
  end
end
