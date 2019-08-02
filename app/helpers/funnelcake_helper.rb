module FunnelcakeHelper

  def about_url()
    config = YAML.load_file(File.expand_path("#{Rails.root}/config/funnelcake.yml", __FILE__))
    @about_url = config['about_url']
  end

end
