module ApplicationHelper
  class HtmlWithPrettyPrint < Redcarpet::Render::HTML
    def postprocess(full_document)
      full_document.gsub('prettyprint', 'prettyprint linenums')
    end
  end

  def h_application_format_markdown(text)
    # html_render = HTMLwithCoderay.new(filter_html: true, hard_wrap: true, prettify: true)
    html_render = HtmlWithPrettyPrint.new(prettify: true)
    options = {
      autolink: true,
      space_after_headers: true,
      fenced_code_blocks: true,
      tables: true
    }
    markdown    = Redcarpet::Markdown.new(html_render, options)
    markdown.render(text).html_safe
  end
end
