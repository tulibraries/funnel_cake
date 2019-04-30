# frozen_string_literal: true

# configuration_file.rb
# Note that "#" is a comment, cause it's just ruby

require "traject/macros/nokogiri_macros"
extend Traject::Macros::NokogiriMacros

settings do
  # Where to find solr server to write to
  provide "solr.url", "http://localhost:8983/solr"

  # solr.version doesn't currently do anything, but set it
  # anyway, in the future it will warn you if you have settings
  # that may not work with your version.
  provide "solr.version", "4.3.0"

  # various others...
  provide "solr_writer.commit_on_close", "true"

  provide "nokogiri.namespaces", {
    "oai" => "http://www.openarchives.org/OAI/2.0/",
    "dc" => "http://purl.org/dc/elements/1.1/",
    "oai_dc" => "http://www.openarchives.org/OAI/2.0/oai_dc/"
  }

  provide "nokogiri.each_record_xpath", "//oai:record" 
end

# DPLA MAP
to_field "collection", extract_xpath("//dcterms:isPartOf")
to_field "contributor", extract_xpath("//dcterms:contributor")
to_field "creator", extract_xpath("//dcterms:creator")
to_field "date", extract_xpath("//dcterms:date")
to_field "description", extract_xpath("//dcterms:description")
to_field "extent", extract_xpath("//dcterms:extent")
to_field "format", extract_xpath("//dcterms:format")
to_field "identifier", extract_xpath("//dcterms:identifier")
to_field "language", extract_xpath("//dcterms:language")
to_field "spatial", extract_xpath("//dcterms:spatial")
to_field "publisher", extract_xpath("//dcterms:publisher")
to_field "relation", extract_xpath("//dcterms:relation")
to_field "replacedBy", extract_xpath("//dcterms:isReplacedBy")
to_field "replaces", extract_xpath("//dcterms:replaces")

to_field "rightsHolder", extract_xpath("//dcterms:rightsholder")
to_field "source", extract_xpath("//dcterms:source")
to_field "subject", extract_xpath("//dcterms:subject")
to_field "genre", extract_xpath("//edm:hasType")
to_field "temporalCoverage", extract_xpath("//dcterms:temporal")
to_field "title", extract_xpath("//dcterms:title")
to_field "type", extract_xpath("//dcterms:type")

# edm:WebResources

to_field "fileFormat", extract_xpath("//schema:fileFormat")
to_field "rights", extract_xpath("//dcterms:rights")
to_field "rightsUri", extract_xpath("//edm:rights")
to_field "iiifManifest", extract_xpath("//dcterms:isReferencedBy")
to_field "iiifBaseUrl", extract_xpath("//svcs:hasService")

# ore:Aggregation

to_field "dataProvider", extract_xpath("edm:dataProvider")
to_field "url", extract_xpath("edm:isShownAt")
to_field "intermediateProvider", extract_xpath("dpla:intermediateProvider")
to_field "preview", extract_xpath("edm:preview")
to_field "provider", extract_xpath("edm:provider")
