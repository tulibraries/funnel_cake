require 'csv'

class CsvController < CatalogController


  def index

    params[:per_page] = 100
    @search_state = search_state_class.new(params, blacklight_config, self)
    (@response, @document_list) = search_service.search_results
    @rows = @response[:responseHeader][:params][:rows]
    @start = @response[:response][:start]
    @num_return = @response[:response][:numFound]
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
    "#{params.fetch(:q,"no-query")}#{params.fetch(:f,{}).keys.join("-")}"
  end

  def render_search_results_as_csv
    show_fields = blacklight_config.show_fields.map {|solr_name, show_field| {solr_name: solr_name, label: show_field.label } }
    csv_result = CSV.generate(headers: true) do |csv|
      csv << show_fields.map { |field| field[:label] }
      page = 1
      #Loop through all results, not just first page
      while (@start < @num_return )
        @document_list.each do |doc|
          csv << show_fields.map { |field| Array(doc.fetch(field[:solr_name], nil)).join(" ; ") }
        end
        @start += @rows.to_i
        page += 1
        params[:page] = page
        @search_state = search_state_class.new(params, blacklight_config, self)
        (@response, @document_list) = search_service.search_results if @start < @num_return
      end
    end
  end
end
