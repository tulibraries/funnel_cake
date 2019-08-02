require "auto-linker"

module BlacklightHelper
  include Blacklight::BlacklightHelperBehavior

  def autolinker(text, options = {})
    return Autolinker.parse(text[:value].first).html_safe
  end

  def delimited_link_to_facet(args)
    args[:document][args[:field]].map { |item|
			link_to item, "/?f[#{args[:field]}][]=#{item}"
		}.join("; ").html_safe
  end
end
