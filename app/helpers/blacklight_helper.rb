# frozen_string_literal: true

module BlacklightHelper
  include Blacklight::BlacklightHelperBehavior

  def record_page_links(text, options = {})
    text[:value].map do |value|
      link_to(value, value, target: "_blank", rel: "noopener")
    end.join(" ").html_safe
  end

  def render_default_thumbnail_link(document, options = {})
    default_thumb = document["preview_ssim"].present? ? (image_tag(document["preview_ssim"].first, alt: document["title_tsim"].to_sentence)) : nil

    return default_thumb
  end

  def sidebar_classes
    "page-sidebar col-md-4"
  end

  def main_content_classes
    "col-md-8"
  end
end
