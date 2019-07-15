# frozen_string_literal: true

# configuration_file.rb
# Note that "#" is a comment, cause it's just ruby

$:.unshift "./config"
$:.unshift "./lib"
require "yaml"

solr_config = YAML.load_file("config/blacklight.yml")[(ENV["RAILS_ENV"] || "development")]
solr_url = ERB.new(solr_config["url"]).result

require "traject/macros/nokogiri_macros"
extend Traject::Macros::NokogiriMacros

settings do
  provide "solr.version", "8.0.0"
	provide "solr_writer.max_skipped", -1
	provide "solr_writer.commit_timeout", (15 * 60)
  provide "solr.url", solr_url
  provide "solr_writer.commit_on_close", "true"

  provide "nokogiri.namespaces", {
    "oai" => "http://www.openarchives.org/OAI/2.0/",
    "dc" => "http://purl.org/dc/elements/1.1/",
    "dcterms" => "http://purl.org/dc/terms/",
    "oai_dc" => "http://www.openarchives.org/OAI/2.0/oai_dc/",
    "edm" => "http://www.europeana.eu/schemas/edm/",
    "dpla" => "http://dp.la/about/map/",
    "schema" => "http://schema.org",
    "oai_qdc" => "http://worldcat.org/xmlschemas/qdc-1.0/",
    "svcs" => "http://rdfs.org/sioc/services"
  }

  provide "nokogiri.each_record_xpath", "//oai:record"
  provide "nokogiri.strict_mode", "false"
end

# DPLA MAP
to_field "id", extract_xpath("//dcterms:identifier")
to_field "collection_ssim", extract_xpath("//dcterms:isPartOf")
to_field "contributor_ssim", extract_xpath("//dcterms:contributor")
to_field "creator_ssim", extract_xpath("//dcterms:creator")
to_field "date_ssim", extract_xpath("//dcterms:date")
to_field "description_tsim", extract_xpath("//dcterms:description")
to_field "extent_ssim", extract_xpath("//dcterms:extent")
to_field "format", extract_xpath("//dcterms:format")
#to_field "identifier", extract_xpath("//dcterms:identifier")
to_field "language_ssim", extract_xpath("//dcterms:language")
to_field "spatial_ssim", extract_xpath("//dcterms:spatial")
to_field "publisher_ssim", extract_xpath("//dcterms:publisher")
to_field "relation_ssim", extract_xpath("//dcterms:relation")
to_field "replacedBy_ssim", extract_xpath("//dcterms:isReplacedBy")
to_field "replaces_ssim", extract_xpath("//dcterms:replaces")

to_field "rightsHolder_ssim", extract_xpath("//dcterms:rightsholder")
to_field "source_ssim", extract_xpath("//dcterms:source")
to_field "subject_ssim", extract_xpath("//dcterms:subject")
to_field "genre_ssim", extract_xpath("//edm:hasType")
to_field "temporalCoverage_ssim", extract_xpath("//dcterms:temporal")
to_field "title_tsim", extract_xpath("//dcterms:title")
to_field "type_tsim", extract_xpath("//dcterms:type")

# edm:WebResources

to_field "fileFormat_ssim", extract_xpath("//schema:fileFormat")
to_field "rights_ssim", extract_xpath("//dcterms:rights")
to_field "rightsUri_ssim", extract_xpath("//edm:rights")
to_field "iiifManifest_ssim", extract_xpath("//dcterms:isReferencedBy")
to_field "iiifBaseUrl_ssim", extract_xpath("//svcs:hasService")

# ore:Aggregation

to_field "dataProvider_ssim", extract_xpath("//edm:dataProvider")
to_field "url_ssim", extract_xpath("//edm:isShownAt")
to_field "intermediateProvider_ssim", extract_xpath("//dpla:intermediateProvider")
to_field "preview_ssim", extract_xpath("//edm:preview")
to_field "provider_ssim", extract_xpath("//edm:provider")
