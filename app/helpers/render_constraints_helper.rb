module RenderConstraintsHelper
  include Blacklight::RenderConstraintsHelperBehavior

  def render_constraint_element(label, value, options = {})
    value = value.respond_to?(:map) ? value.first : value
    super(label, value, options)
  end
end
