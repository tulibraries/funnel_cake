# frozen_string_literal: true

module Funnelcake
  class StaffViewComponent < Blacklight::Component
    def initialize(document:)
      @document = document
    end

    def call
      tag.div(class: "row") do
        tag.div(class: "col-12") do
          tag.dl(class: "row dl-invert document-metadata") do
            tag.dt(class: "align-self-center col-md-3") do
              helpers.staff_view_link(@document.id)
            end
          end
        end
      end
    end
  end
end
