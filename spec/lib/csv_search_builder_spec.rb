# frozen_string_literal: true

require "rails_helper"

RSpec.describe CsvSearchBuilder , type: :model do
  let(:context) { CsvController.new }
  let(:params) { ActionController::Parameters.new }
  let(:search_builder) { described_class.new(context) }
  let(:solr_parameters) { Blacklight::Solr::Request.new() }

  subject { search_builder }

  it "Should include a journals_facet search preprocessor" do
    expect(subject.default_processor_chain).to include(:add_cursor_mark)
  end

  describe "#add_cursor_mark" do
    let(:prepocess) {}
    before(:each) do
      prepocess
      subject.add_cursor_mark(solr_parameters)
    end

    it "adds a * as cursorMark by default" do
      expect(solr_parameters["cursorMark"]).to eq("*")
    end

    it "is idempotent" do
      subject.add_cursor_mark(solr_parameters)
      expect(solr_parameters["cursorMark"]).to eq("*")
    end

    context "when a cursorMark is in the solr repsonse" do
      let(:prepocess) { subject.blacklight_params["cursorMark"] = "newCursorMark" }
      it "adds the nextCursorMark to the cursorMark paramter when defined" do
        expect(solr_parameters["cursorMark"]).to eq("newCursorMark")
      end
    end

    it "sets rows to the batch size" do
      expect(solr_parameters["rows"]).to eq(described_class::ROWS_PER_BATCH)
    end

    it "limits the returned fields to the ones the csv renders" do
      expect(solr_parameters["fl"].split(",")).to match_array(
        (subject.blacklight_config.show_fields.keys + ["id"]).uniq)
    end

    it "adds a custom sort" do
      expect(solr_parameters[:sort]).to eq("date_si desc, id asc")
    end
  end
end
