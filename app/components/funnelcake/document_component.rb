# frozen_string_literal: true

module Funnelcake
  class DocumentComponent < Blacklight::DocumentComponent
    def before_render
      super

      with_metadata_section do
        render Funnelcake::StaffViewComponent.new(document: presenter.document)
      end
    end
  end
end
