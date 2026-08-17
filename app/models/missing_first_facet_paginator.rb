# frozen_string_literal: true

# Solr appends the facet.missing bucket after the values it returns for a page,
# so the base paginator truncates it away on any full page and it only survives
# on the last one. Pull it out of the paged values and show it first, on the
# first page only.
class MissingFirstFacetPaginator < Blacklight::Solr::FacetPaginator
  def items
    return items_for_limit(values) unless first_page?

    missing_values + items_for_limit(values)
  end

  # The missing bucket is not one of the field's values, so it should not count
  # toward whether there is another page of them.
  def total_count
    values.size
  end

  private

    def missing_values
      @missing_values ||= @all.select { |item| missing_value?(item) && item.hits.to_i.positive? }
    end

    def values
      @values ||= @all.reject { |item| missing_value?(item) }
    end

    def missing_value?(item)
      item.respond_to?(:missing) && item.missing
    end
end
