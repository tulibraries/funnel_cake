# frozen_string_literal: true

require "rails_helper"

RSpec.describe CsvController, type: :controller do
  describe "#csv_stream" do
    subject(:stream) { controller.csv_stream }

    it "is lazy: the header row is produced without querying solr" do
      expect(stream.next).to start_with("Title,Alternative Title")
      expect(WebMock).not_to have_requested(:any, /solr/)
    end

    it "labels every configured show field" do
      labels = stream.next.parse_csv
      expect(labels).to eq(controller.blacklight_config.show_fields.values.map(&:label))
    end
  end
end
