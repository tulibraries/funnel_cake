# frozen_string_literal: true

module FunnelCake
  class DocumentComponent < Blacklight::DocumentComponent
    def before_render
      super

      with_metadata_section do
        render FunnelCake::StaffViewComponent.new(document: presenter.document)
      end
    end
  end
end
