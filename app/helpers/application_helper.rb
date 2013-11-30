module ApplicationHelper

  def h_application_format_markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
    markdown.render(text).html_safe
  end

end
