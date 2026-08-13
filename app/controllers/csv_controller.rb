# frozen_string_literal: true

require "csv"

class CsvController < CatalogController
  configure_blacklight do |config|
    config.search_builder_class = CsvSearchBuilder
  end

  def index
    respond_to do |format|
      format.csv do
        response.headers["Content-Type"] = "text/csv; charset=utf-8"
        response.headers["Content-Disposition"] = ActionDispatch::Http::ContentDisposition.format(
          disposition: "attachment", filename: "#{csv_file_name}.csv")
        response.headers["Cache-Control"] = "no-cache"
        response.headers["Last-Modified"] = Time.current.httpdate
        response.headers["X-Accel-Buffering"] = "no"
        response.headers.delete("Content-Length")

        self.response_body = csv_stream
      end
    end
  end

  def csv_file_name
    "#{params.fetch(:q, "no-query")}#{params.fetch(:f, {}).keys.join("-")}"
  end


  COL_SEP = "|"

  def csv_stream
    fields = csv_fields
    Enumerator.new do |csv|
      csv << CSV.generate_line(fields.map { |field| field[:label] }, col_sep: COL_SEP)
      each_document do |doc|
        csv << CSV.generate_line(fields.map { |field| Array(doc.fetch(field[:solr_name], nil)).join(" ; ") }, col_sep: COL_SEP)
      end
    end
  end

  private

    def csv_fields
      blacklight_config.show_fields.map { |solr_name, show_field| { solr_name: solr_name, label: show_field.label } }
    end

    # Page through the entire result set with Solr's cursorMark, yielding every
    # document. Solr marks the end of the set by echoing back the cursorMark
    # that was requested. CursorMark params logic is handled by the additional
    # processor chain step in CsvSearchBuilder.
    def each_document
      cursor_mark = "*"
      loop do
        solr_response = search_results_for(cursor_mark)
        solr_response.documents.each { |doc| yield doc }
        next_cursor_mark = solr_response["nextCursorMark"]
        break if next_cursor_mark.blank? || next_cursor_mark == cursor_mark
        cursor_mark = next_cursor_mark
      end
    end

    def search_results_for(cursor_mark)
      @search_state = search_state_class.new(params.merge("cursorMark" => cursor_mark), blacklight_config, self)
      search_service.search_results
    end
end
