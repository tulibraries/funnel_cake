# frozen_string_literal: true

class FunnelCake::ShowPresenter < Blacklight::ShowPresenter
  self.thumbnail_presenter = FunnelCake::ThumbnailPresenter
end
