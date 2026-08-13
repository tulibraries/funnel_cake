# frozen_string_literal: true

class CsvSearchBuilder < ::SearchBuilder
  # remove the params to return facets since we don't use those
  # values to construct the csv.
  # We do want the apply the facet filters and query, though, so the
  # csv export is limited to the expected results
  self.default_processor_chain = [
    :default_solr_parameters,
    :add_query_to_solr,
    :add_facet_fq_to_solr,
    :add_solr_fields_to_query,
    :add_cursor_mark
  ]

  # Documents fetched per cursorMark request. Bigger batches mean fewer Solr
  # round trips, which dominate the cost of a large export.
  ROWS_PER_BATCH = "2000"

  def add_cursor_mark(solr_parameters)
    solr_parameters[:sort] = "date_si desc, id asc"
    solr_parameters[:rows] = ROWS_PER_BATCH
    # Only the fields the csv actually renders need to come back from Solr.
    solr_parameters[:fl] = csv_field_list
    if blacklight_params["cursorMark"]
      solr_parameters[:cursorMark] = blacklight_params["cursorMark"]
    else
      solr_parameters[:cursorMark] = "*"
    end
  end

  private

    def csv_field_list
      unique_key = blacklight_config.document_model.unique_key || "id"
      (blacklight_config.show_fields.keys + [unique_key]).uniq.join(",")
    end
end
