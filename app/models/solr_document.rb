# frozen_string_literal: true

class SolrDocument
  include Blacklight::Solr::Document

  # self.unique_key = 'id'

  # Email uses the semantic field mappings below to generate the body of an email.
  SolrDocument.use_extension(Blacklight::Document::Email)

  # SMS uses the semantic field mappings below to generate the body of an SMS email.
  SolrDocument.use_extension(Blacklight::Document::Sms)

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  # Semantic mappings of solr stored fields. Fields may be multi or
  # single valued. See Blacklight::Document::SemanticFields#field_semantics
  # and Blacklight::Document::SemanticFields#to_semantic_values
  # Recommendation: Use field names from Dublin Core
  use_extension(Blacklight::Document::DublinCore)

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
