class TagsDecorator < Draper::CollectionDecorator

  # tagをtree viewで表示する
  def tree_view
    _html = ''
    _html += %Q{
      <ul class="mod-tag-tree">
        <input type="search" class="mod-tag-tree-filter form-control" placeholder="filter...">
    }
    self.each do |_node|
      _html += %Q{
        <li>
          #{_node.decorate.tree_view_node}
        </li>
      }
    end
    _html += "</ul>"

    _html.html_safe
  end

end
