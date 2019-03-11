module ApplicationHelper

  def h_application_format_markdown(text)
    raise "deplicated error"
    text = GitHub::Markdown.render_gfm(text)
    text.html_safe
  end

end
