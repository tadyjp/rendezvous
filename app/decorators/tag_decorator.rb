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
    h.tag_path(name: model.name)
  end

  def edit_path
    h.edit_tag_path(name: model.name)
  end

  def event_tag_path
    h.event_tag_path(name: model.name)
  end

  # TODO: module
  def created_date
    model.created_at.strftime('%Y-%m-%d')
  end

  def structured_name
    [model.ancestors.map(&:name), model.name].flatten.join('/')
  end

  # tagをtree viewで表示する
  def tree_view_node
    html = ''

    html += %(
      <a href="#{show_path}" data-name="#{model.name}">
        #{model.name} <span class="badge">#{model.posts.size}</span>
      </a>
        )

    html += '<ul>'
    model.children.each do |child|
      html += '<li>'
      html << child.decorate.tree_view_node
      html += '</li>'
    end
    html += '</ul>'

    html.html_safe
  end
end
