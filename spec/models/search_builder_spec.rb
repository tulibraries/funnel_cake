# frozen_string_literal: true

require "rails_helper"

RSpec.describe SearchBuilder, api: true do
  subject(:builder) { described_class.new processor_chain, scope }

  let(:processor_chain) { [] }
  let(:blacklight_config) { Blacklight::Configuration.new }
  let(:scope) { double blacklight_config: blacklight_config }

  context "with default processor chain" do
    subject { described_class.new scope }

    it "appends the :add_missing_field_query processor" do
      expect(subject.processor_chain).to include(:add_missing_field_query)
    end
  end

  describe "#add_missing_field_query" do
    it "precesses facet.missing query" do
      subject.with("f" => { "-hello:" => [""] })
      solr_params = { "facet.missing" => true, fq: [] }

      expect(subject.add_missing_field_query(solr_params)).to eq(["-hello:[* TO *]"])
    end
  end
end
