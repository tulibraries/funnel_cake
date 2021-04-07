# frozen_string_literal: true

class DplaOaiController < ApplicationController
  include Blacklight::Catalog
  include BlacklightOaiProvider::Controller

  configure_blacklight do |config|
    config.oai = {
      repository_url: "/oai",
      provider: {
        repository_name: "PA Digital Funnel Cake OAI",
        repository_url: "https://funnelcake.padigital.org/oai",
        record_prefix: "oai:funnel_cake",
        admin_email: "tug34268@temple.edu",
        deletion_support: "persistent",
        sample_id: "109660"
      },
      document: {
        set_fields: [
          { label: "Set", solr_field: "set_ssim" }
        ],
        limit: 1000
      }
    }
    config.default_document_solr_params = {
      qt: "search",
      fl: "*",
      rows: 1,
      facet: false,
    }
    config.document_unique_id_param = "id"
    config.document_solr_path = "select"
    config.connection_config = config.connection_config.dup
    config.connection_config[:url] = config.connection_config[:funcake_oai_prod_solr_url]
    config.document_model = OaiDocument
  end

  # Overrides BlacklightOaiProvider::Controller.oai
  #
  # Overridden to remove hard coded styling.
  # @see https://github.com/projectblacklight/blacklight_oai_provider/issues/21
  def oai
    body = oai_provider.process_request(oai_params.to_h)
    render xml: body, content_type: "text/xml"
  end
end
