module StyleHelper

  ## Store style
  # Usage:
  #   <% style do %>
  #     div {
  #       color: red;
  #     }
  #   <% end %>
  def style(&block)
    content_for(content_key, capture(&block))
  end

  ## Render all style
  def render_style
    return if content_for(content_key).nil?

    html_buf = '<style type="text/css">'
    html_buf << content_for(content_key)
    html_buf << '</style>'
    html_buf.html_safe
  end

  private

  # Use for `content_for`
  def content_key
    :style_addon
  end
end
