# frozen_string_literal: true

require "rails_helper"

# check the methods that do solr requests. Note that we are not testing if
#  solr gives "correct" responses, as that's out of scope (it's a part of
#  testing the solr code itself).  We *are* testing if blacklight code sends
#  queries to solr such that it gets appropriate results. When a user does a search,
#  do we get data back from solr (i.e. did we properly configure blacklight code
#  to talk with solr and get results)? when we do a document request, does
#  blacklight code get a single document returned?)
#
RSpec.describe FunnelCake::SearchService, api: true do
  subject { service }

  let(:context) { { whatever: :value } }
  let(:service) { described_class.new(config: blacklight_config, user_params: user_params, **context) }
  let(:repository) { Blacklight::Solr::Repository.new(blacklight_config) }
  let(:user_params) { {} }

  let(:blacklight_config) { Blacklight::Configuration.new }
  let(:copy_of_catalog_config) { ::CatalogController.blacklight_config.deep_copy }
  let(:blacklight_solr) { RSolr.connect(Blacklight.connection_config.except(:adapter)) }
  let(:solr_response) { double Blacklight::Solr::Response }

  let(:all_docs_query) { "" }
  let(:no_docs_query) { "zzzzzzzzzzzz" }
  #  f[format][]=Book&f[language_facet][]=English
  let(:single_facet) { { format: "Book" } }

  before do
    allow(service).to receive(:repository).and_return(repository)
    allow(solr_response).to receive(:documents).and_return([])
    service.repository.connection = blacklight_solr
  end

  describe "#fetch_one" do

    context "fetch with out extra params" do
      it "remove" do
        allow(repository).to receive(:send_and_receive).and_return(solr_response)
        service.send(:fetch_one, "foo:bar")
        expect(repository).to have_received(:send_and_receive).with("select", { fq: "id:foo\\:bar" })
      end
    end

    context "fetch with extra params" do
      it "remove" do
        allow(repository).to receive(:send_and_receive).and_return(solr_response)
        service.send(:fetch_one, "foo:bar", { "bizz" => "buzz" })
        expect(repository).to have_received(:send_and_receive).with("select", { fq: "id:foo\\:bar", "bizz" => "buzz" })
      end
    end

  end
end
