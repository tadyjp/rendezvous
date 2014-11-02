class TagsDecorator < Draper::CollectionDecorator
  # tagをtree viewで表示する
  def tree_view
    html = ''
    html += %(
      <ul class="mod-tag-tree">
        <input type="search" class="mod-tag-tree-filter form-control" placeholder="filter...">
        )
    each do |node|
      html += %(
        <li>
          #{node.decorate.tree_view_node}
        </li>
            )
    end
    html += '</ul>'

    html.html_safe
  end
end
