module ApplicationHelper

  def h_application_format_markdown(text)
    text = GitHub::Markdown.render_gfm(text)
    text.html_safe
  end

end
