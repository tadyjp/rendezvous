module ApplicationHelper

  class MarkdownRenderer < Redcarpet::Render::HTML
    def block_code(code, language)
      return "<div class='CodeRay'><div class='code'><pre>#{code}</pre></div></div>" if language.blank?
      CodeRay.highlight(code, language.gsub(/[^[:alnum:]].*/, ""))
    end
  end

  def markdown(text)
    rndr = MarkdownRenderer.new(:filter_html => true, :hard_wrap => true)
    options = {
      :fenced_code_blocks => true,
      :no_intra_emphasis => true,
      :autolink => true,
      :strikethrough => true,
      :lax_html_blocks => true,
      :superscript => true
    }
    markdown_to_html = Redcarpet::Markdown.new(rndr, options)
    markdown_to_html.render(text).html_safe
  end

  def h_application_format_markdown(text)
    text = GitHub::Markdown.render_gfm(text)
    text.html_safe
  end

end
