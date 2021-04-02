# frozen_string_literal: true

require "auto-linker"

module BlacklightHelper
  include Blacklight::BlacklightHelperBehavior

  def autolinker(text, options = {})
    return Autolinker.parse(text[:value].first).html_safe
  end

  def render_default_thumbnail_link(document, options = {})
    return if document["preview_ssim"] == ["NULL"]
    document["preview_ssim"].present? ? (image_tag(document["preview_ssim"].first, alt: document["title_tsim"].to_sentence)) : nil
  end

  def sidebar_classes
    "page-sidebar col-md-4"
  end

  def main_content_classes
    "col-md-8"
  end
end
