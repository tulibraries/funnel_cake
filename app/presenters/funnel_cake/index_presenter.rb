# frozen_string_literal: true

class FunnelCake::IndexPresenter < Blacklight::IndexPresenter
  self.thumbnail_presenter = FunnelCake::ThumbnailPresenter
end
