# frozen_string_literal: true

module FunnelCake
  class SearchService < ::Blacklight::SearchService
    # Overridden as workaround to Solr RealTime Get not working.
    # REF #FLYPIE-271
    #
    # @TODO: remove once we get Solr RealTime Get working for FunnelCake OAI.
    def fetch_one(id, params = {})
      solr_response = repository.send_and_receive("select", { fq: "id:#{id.gsub(":", "\\:")}" }
        .reverse_merge(params))
      [solr_response, solr_response.documents.first]
    end
  end
end
