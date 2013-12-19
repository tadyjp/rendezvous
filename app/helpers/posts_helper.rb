module PostsHelper

  # @param {ActiveRecord::Relation} node
  def h_display_tree(node)
    _html = '<ul>'
    _html << %Q{<li><a href="#{ root_path(q: '#' + node.name) }">#{node.name}</a></li>}
    node.children.each do |_child|
      _html << h_display_tree(_child)
    end
    _html << '</ul>'
    _html.html_safe
  end

end
