class TagDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  decorates_association :posts

  # tagページのURL
  # urlエンコードを施す
  def show_path
    h.tag_path(name: h.url_encode(model.name))
  end

  def edit_path
    h.edit_tag_path(name: h.url_encode(model.name))
  end

  def event_tag_path
    h.event_tag_path(name: h.url_encode(model.name))
  end

  # tagをtree viewで表示する
  def tree_view_node
    _html = ''

    _html += %Q{
      <a href="#{ self.show_path }" data-name="#{model.name}">
        #{model.name} <span class="badge">#{model.posts.size}</span>
      </a>
    }

    _html += '<ul>'
    model.children.each do |_child|
      _html += '<li>'
      _html << _child.decorate.tree_view_node
      _html += '</li>'
    end
    _html += '</ul>'

    _html.html_safe
  end

end
