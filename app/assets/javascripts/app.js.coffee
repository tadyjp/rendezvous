$ ->

  # 上部の検索フォームのアニメーション
  $('#app-search-form input')
  .on 'focus', ->
    $(this).parents('#app-search-form').animate({width: '400px'})
  .on 'blur', ->
    $(this).parents('#app-search-form').animate({width: '200px'})

  # コードハイライト
  # TODO
  prettyPrint()


