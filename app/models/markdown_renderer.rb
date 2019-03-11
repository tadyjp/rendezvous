class MarkdownRenderer
  def initialize(text)
    @text = text || ''
  end

  def render
    GitHub::Markdown.render_gfm(@text).html_safe
  end
end
