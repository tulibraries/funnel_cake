# frozen_string_literal: true

require "rails_helper"

RSpec.describe Blacklight::SearchState::FilterField do
  let(:search_state) { FunnelCake::SearchState.new(params.with_indifferent_access, blacklight_config, controller) }

  let(:blacklight_config) do
    Blacklight::Configuration.new.configure do |config|
      config.add_facet_field "some_field"
      config.add_facet_field "another_field", single: true
    end
  end
  let(:controller) { double }

  describe "#remove" do
    context "With facet.missing field" do
      let(:params) do
        { f: { some_field: [""], "-some_field:": [""] } }
      end

      it "removes facet.missing facet params" do
        filter = search_state.filter("some_field")
        new_state = filter.remove(OpenStruct.new(fq: "-some_field:[* TO *]"))

        expect(new_state.params).to eq("f" => {})
      end
    end

    context "With facet.missing field value" do
      let(:params) do
        { f: { some_field: [""], "-some_field:": [""] } }
      end

      it "removes facet.missing facet params" do
        filter = search_state.filter("some_field")
        new_state = filter.remove("[Missing]")

        expect(new_state.params).to eq("f" => {})
      end
    end
  end
end
