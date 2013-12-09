if window.location.pathname.match /^\/$/

  $ ->

    # Listをクリックしたら右側に詳細を表示
    $('.post-list').on 'click', (e) ->
      e.preventDefault()
      $this = $(this)

      $this.siblings().removeClass('active')
      $this.addClass('active')

      id = $this.data('postId')
      $.get('/posts/show_fragment', { id: id })
      .done (data) ->
        $('#list_post').html(data)

    # 初期に詳細を表示
    # open post when `id` parameter set.


    id_param = RV.tools.getQueryParams()["id"]
    if id_param?
      $(".post-list[data-post-id='#{id_param}']").addClass('active')
      $.get('/posts/show_fragment', {
        'id': id_param,
      })
      .done (data) ->
        $('#list_post').html(data)

    #  search form animation
    $('#app-search-form input')
    .on 'focus', ->
      $(this).parents('#app-search-form').animate({width: '600px'})
    .on 'blur', ->
      $(this).parents('#app-search-form').animate({width: '200px'})

