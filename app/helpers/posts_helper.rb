module PostsHelper
  # # @param {ActiveRecord::Relation} node
  # def h_display_tree_old(node)
  #   _html = '<ul>'
  #   if node.posts.count > 0
  #     _html << %Q{
  #       <li>
  #         <a href="#{ posts_path(q: '#' + node.name) }">#{node.name} <span class="badge">#{node.posts.count}</span></a>
  #       </li>
  #     }
  #   end
  #   node.children.each do |_child|
  #     _html << h_display_tree(_child)
  #   end
  #   _html << '</ul>'

  #   _html.html_safe
  # end

  # # @param {ActiveRecord::Relation} node
  # def h_display_tree(node)
  #   _html = ''
  #   _html += %Q{
  #     <a href="#{ posts_path(q: '#' + node.name) }" data-name="#{node.name}">
  #       #{node.name} <span class="badge">#{node.posts.count}</span>
  #     </a>
  #   }

  #   _html += '<ul>'
  #   node.children.each do |_child|
  #     _html += '<li>'
  #     _html << h_display_tree(_child)
  #     _html += '</li>'
  #   end
  #   _html << '</ul>'

  #   _html.html_safe
  # end
end
