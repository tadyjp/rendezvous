module ApplicationHelper

  class HTMLwithCoderay < Redcarpet::Render::HTML
    def block_code(code, language)
      case language.to_s
      when 'rb'
        lang = 'ruby'
      when 'yml'
        lang = 'yaml'
      when ''
        lang = 'md'
      else
        lang = 'md'
      end

      CodeRay.scan(code, lang).div
    end
  end


  def h_application_format_markdown(text)
    html_render = HTMLwithCoderay.new(filter_html: true, hard_wrap: true)
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
