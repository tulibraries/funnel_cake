# frozen_string_literal: true

module Blacklight
  module Document
    # Render the 'Staff View Link' results from the response
    class StaffViewLinkComponent < Blacklight::Component
      def initialize(document_id)
        @document_id = document_id
      end
    end
  end
end
