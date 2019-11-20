# frozen_string_literal: true
class OaiDocument
  include Blacklight::Solr::Document
  include BlacklightOaiProvider::SolrDocument

  def export_as_oai_dc_xml
    self["payload_ss"]
  end
end
