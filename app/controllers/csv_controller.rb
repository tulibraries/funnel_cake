# frozen_string_literal: true

require "csv"

class CsvController < CatalogController
  configure_blacklight do |config|
    config.search_builder_class = CsvSearchBuilder
  end

  def index
    @search_state = search_state_class.new(params, blacklight_config, self)
    @response = search_service.search_results
    @document_list = @response.documents
    respond_to do |format|
      format.csv do
        send_data render_search_results_as_csv,
          filename: "#{csv_file_name}.csv",
          disposition: "attachment",
          type: "text/csv"
      end
    end
  end


  def csv_file_name
    "#{params.fetch(:q, "no-query")}#{params.fetch(:f, {}).keys.join("-")}"
  end

  def render_search_results_as_csv
    show_fields = blacklight_config.show_fields.map { |solr_name, show_field| { solr_name: solr_name, label: show_field.label } }
    csv_result = CSV.generate(headers: true) do |csv|
      csv << show_fields.map { |field| field[:label] }
      # Loop through all results until response nextCursorMark is the same as requested cursorMark
      # CursorMark params logic is handled by the additional processor chain step in CsvSearchBuilder
      while (@response["nextCursorMark"] != params["cursorMark"])
        binding.pry
        @document_list.each do |doc|
          csv << show_fields.map { |field| Array(doc.fetch(field[:solr_name], nil)).join(" ; ") }
        end
        params["cursorMark"] = @response["nextCursorMark"]
        @search_state = search_state_class.new(params, blacklight_config, self)
				@response = search_service.search_results
				@document_list = @response.documents
      end
    end
  end
end
