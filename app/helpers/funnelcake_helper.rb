# frozen_string_literal: true

module FunnelcakeHelper
  def about_url()
    Rails.configuration.funnel_cake[:about_url]
  end

  def staff_view_link(id)
    link_to "Staff View", solr_document_path(id: id, format: "xml"), data: { "turbolinks" => false }
  end
end
