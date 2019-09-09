module FunnelcakeHelper

  def about_url()
    @about_url = Rails.configuration.funnel_cake[:about_url]
  end

end
