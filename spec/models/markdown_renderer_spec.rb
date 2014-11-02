require 'rails_helper'

RSpec.describe MarkdownRenderer, type: :model do
  it 'tests #render' do
    renderer = MarkdownRenderer.new(<<EOS)
# title

- body
- test
EOS
    expect(renderer.render.to_s.gsub(/^ +/, '')).to eq(<<EOS)
<h1>title</h1>

<ul>
<li>body</li>
<li>test</li>
</ul>
EOS
  end

  it 'tests #render with slides' do
    renderer = MarkdownRenderer.new(<<EOS)
!slide!(http://test.com/slide-1.pdf)
!slide!(http://test.com/slide-2.pdf)
EOS
    expect(renderer.render.to_s.gsub(/^ +/, '')).to eq(<<EOS)
<p>
<div class="embed-responsive embed-responsive-4by3">
<iframe style="text-align:center;" src="/ViewerJS/#http://test.com/slide-1.pdf" width="400" height="300" allowfullscreen="true" webkitallowfullscreen="true"></iframe>
</div>
<br>

<div class="embed-responsive embed-responsive-4by3">
<iframe style="text-align:center;" src="/ViewerJS/#http://test.com/slide-2.pdf" width="400" height="300" allowfullscreen="true" webkitallowfullscreen="true"></iframe>
</div>
</p>
EOS
  end
end
