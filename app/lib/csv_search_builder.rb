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

    def add_cursor_mark(solr_parameters)
      solr_parameters[:sort] = "date_si desc, id asc"
      solr_parameters[:rows] = "500"
      if blacklight_params['cursorMark']
        solr_parameters[:cursorMark] = blacklight_params['cursorMark']
      else
        solr_parameters[:cursorMark] = "*"
      end
    end
  end