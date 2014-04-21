# .mod-tag-tree-filterの入力文字列をもとにmod-tag-tree内のliをフィルタリング
$ ->
  $('.mod-tag-tree').each ->
    $root = $(this)

    $root.find('.mod-tag-tree-filter').on 'change keyup', ->
      $input = $(this)

      if _.isEmpty($input.val())
        $root.find('li').show()
        return

      $root.find('li a').each ->
        $a = $(this)

        # aタグに検索文字列が含まれれば表示
        if _.str.include $a.text().toLowerCase(), $input.val().toLowerCase()
          $a.parent('li').show()
        else
          $a.parent('li').hide()



