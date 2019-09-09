require "auto-linker"

module BlacklightHelper
  include Blacklight::BlacklightHelperBehavior

  def autolinker(text, options = {})
    return Autolinker.parse(text[:value].first).html_safe
  end
end
