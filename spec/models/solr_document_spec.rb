# frozen_string_literal: true

require "rails_helper"

RSpec.describe SolrDocument do
  describe "null field initialization" do

    context "null field is 'NULL'" do
      it "sets null field to nil" do
        doc = described_class.new(null_field: "NULL")
        expect(doc["null_field"]).to be_nil
      end
    end

    context "null field is ['NULL']" do
      it "sets null field to nil" do
        doc = described_class.new(null_field: ["NULL"])
        expect(doc["null_field"]).to be_nil
      end
    end

    context "null field is ''" do
      it "sets null field to nil" do
        doc = described_class.new(null_field: "")
        expect(doc["null_field"]).to be_nil
      end
    end

    context "null field is ['']" do
      it "sets null field to nil" do
        doc = described_class.new(null_field: [""])
        expect(doc["null_field"]).to be_nil
      end
    end
  end

  describe "to_xml" do
    context "when document has no payload_ss field" do
      it "transforms xml to nil" do
        doc = described_class.new({})
        expect(doc.to_xml).to be_nil
      end
    end

    context "when document has a payload_ss field" do
      it "transforms xml to value of payload" do
        doc = described_class.new(payload_ss: "<foo></foo>")
        expect(doc.to_xml).to eq("<foo></foo>")
      end
    end
  end
end
