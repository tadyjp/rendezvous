class MarkdownRenderer
  def initialize(text)
    @text = text || ''
  end

  # pdf viewerの変換
  # !slide!(file-url) -> %%slide:0%% -> <iframe>...</iframe>
  def render
    # slideのurlを一時保管
    slide_urls = []
    text = @text.gsub(/!slide!\(([^\)]+)\)/) do |_|
      slide_urls << %(
        <div class="embed-responsive embed-responsive-4by3">
          <iframe style="text-align:center;" src="/ViewerJS/##{Regexp.last_match[1]}"
            width="400" height="300" allowfullscreen="true" webkitallowfullscreen="true"></iframe>
        </div>
            )
      "%%slide:#{slide_urls.size - 1}%%"
    end

    text = GitHub::Markdown.render_gfm(text)

    # 保管したslide urlを取り出す
    text = text.gsub(/%%slide:(\d+)%%/) do |_|
      slide_urls[Regexp.last_match[1].to_i]
    end

    text.html_safe
  end
end
