if window.location.pathname.match /^\/posts\/?$/

  $ ->

    # Listをクリックしたら右側に詳細を表示
    $('.post-list').on 'click', (e) ->
      e.preventDefault()
      $this = $(this)

      $this.siblings().removeClass('active')
      $this.addClass('active')

      id = $this.data('postId')
      $.get("/posts/#{id}", {
        fragment: 1
      })
      .done (data) ->
        $('#list_post').html(data)
        prettyPrint()

    # 初期に詳細を表示
    # open post when `id` parameter set.
    id_param = RV.tools.getQueryParams()["id"]
    if id_param?
      $("a.post-list[data-post-id='#{id_param}']").addClass('active')
      $.get("/posts/#{id_param}", {
        fragment: 1
      })
      .done (data) ->
        $('#list_post').html(data)
        prettyPrint()
    else
      $el = $("a.post-list:eq(0)")
      $el.addClass('active')
      $.get("/posts/#{$el.data('postId')}", {
        fragment: 1
      })
      .done (data) ->
        $('#list_post').html(data)
        prettyPrint()


