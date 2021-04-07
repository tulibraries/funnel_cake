# frozen_string_literal: true

require "rails_helper"

RSpec.describe FunnelCake::SearchState do
  subject(:search_state) { described_class.new(params, blacklight_config, controller) }

  around { |test| Deprecation.silence(described_class) { test.call } }

  let(:blacklight_config) do
    Blacklight::Configuration.new.configure do |config|
      config.index.title_field = "title_tsim"
      config.index.display_type_field = "format"
    end
  end

  let(:parameter_class) { ActionController::Parameters }
  let(:controller) { double }
  let(:params) { parameter_class.new }

  describe "#filter" do
    it "returns a copy of the original parameters" do
      expect(search_state.filter("foo").class).to eq(FunnelCake::SearchState::FilterFieldOverride)
    end
  end
end
