# frozen_string_literal: true

module FunnelcakeHelper
  def about_url()
    Rails.configuration.funnel_cake[:about_url]
  end

  def staff_view_link(id)
    link_to "Staff View", "/oai?verb=GetRecord&identifier=#{id}&metadataPrefix=oai_dc", data: { "turbolinks" => false }
  end
end
