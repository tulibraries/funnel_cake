# frozen_string_literal: true

# Solr returns the facet.missing bucket wherever its count or value happens to
# fall. We always want it first, whether the facet is sorted by count or
# alphabetically, so it reads as a heading rather than a stray value.
class MissingFirstFacetPaginator < Blacklight::Solr::FacetPaginator
  def items
    missing, present = super.partition { |item| item.respond_to?(:missing) && item.missing }
    missing + present
  end
end
