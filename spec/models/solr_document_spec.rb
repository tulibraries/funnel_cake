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
end
