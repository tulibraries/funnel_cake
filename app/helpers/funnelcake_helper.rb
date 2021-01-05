# frozen_string_literal: true

module FunnelcakeHelper
  def about_url()
    Rails.configuration.funnel_cake[:about_url]
  end
end
