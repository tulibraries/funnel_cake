# frozen_string_literal: true
class OaiController < ApplicationController

  include Blacklight::Catalog
  include BlacklightOaiProvider::Controller

  configure_blacklight do |config|
    config.oai = {
      repository_url: '/oai/oai',
      provider: {
        repository_name: 'Test Repository',
        repository_url: 'http://localhost/oai/oai',
        record_prefix: 'oai:test',
        admin_email: 'root@localhost',
        deletion_support: 'persistent',
        sample_id: '109660'
      },
      document: {
        set_fields: [
          { label: 'Set', solr_field: 'set_ssim' }
        ],
        limit: 25
      }
    }
    config.default_document_solr_params = {
      qt: 'search',
      fl: %w[
        *
        payload_ss:xml
        ],
      rows: 1,
      q: '{!raw f=id v=$id}'
    }
    config.connection_config =  config.connection_config.dup
    config.connection_config[:url] = config.connection_config[:funcake_oai_url]
    config.document_model = OaiDocument

  end


end
