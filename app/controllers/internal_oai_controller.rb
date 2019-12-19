# frozen_string_literal: true

class InternalOaiController < ApplicationController
  include Blacklight::Catalog
  include BlacklightOaiProvider::Controller

  configure_blacklight do |config|
    config.oai = {
      repository_url: "/oai_dev",
      provider: {
        repository_name: "PA Digital Funnel Cake OAI for QA",
        repository_url: "https://funnelcake.padigital.org/oai_dev",
        record_prefix: 'oai:funnel_cake',
        admin_email: 'tug34268@temple.edu',
        deletion_support: 'persistent',
        sample_id: '109660'
      },
      document: {
        set_fields: [
          { label: 'Set', solr_field: 'set_ssim' }
        ],
        limit: 1000
      }
    }
    config.default_document_solr_params = {
      qt: 'search',
      fl: '*',
      rows: 1,
      q: '{!raw f=id v=$id}'
    }
    config.connection_config = config.connection_config.dup
    config.connection_config[:url] = config.connection_config[:funcake_oai_dev_solr_url]
    config.document_model = OaiDocument
  end
end