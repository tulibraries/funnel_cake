# frozen_string_literal: true

##
# Custom Funnel Cake Thumbnail Presenter
class FunnelCake::ThumbnailPresenter < Blacklight::ThumbnailPresenter
  private

    # Overriden to skip rendering NULL thumbnails
    def thumbnail_value_from_document
      return if @document[thumbnail_field] == ["NULL"]
      super
    end
end
