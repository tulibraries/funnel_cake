# frozen_string_literal: true


module ExportXml
  def self.extended(document)
    document.will_export_as(:xml)
  end

  def export_as_xml
    self["payload_ss"]
  end

  alias_method :to_xml, :export_as_xml
end

class SolrDocument
  include Blacklight::Solr::Document

  use_extension(ExportXml)

  def initialize(doc, req = nil)
    # TODO:Remove if/when we do this at indexing time.
    doc.keys.each do |field|
      if [ "NULL", ["NULL"], "", [""]].include? doc[field]
        doc[field] = nil
      end
    end
    super
  end
end
