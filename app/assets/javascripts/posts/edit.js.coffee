if window.location.pathname.match /edit|new/

  $ ->

    confirmUnload = ->
      return 'このページを離れますか？'
    $(window).on('beforeunload', confirmUnload)

    $('#save_button').on 'click', ->
      $(window).off('beforeunload', confirmUnload)

    # Automaticaly change textarea height.
    $('textarea.autosize').autosize();

    # disable tab key
    $('.disable-tab').on 'keydown', (e) ->
      $this = $(this)
      keyCode = e.keyCode || e.which

      # tab key
      if keyCode is 9
        e.preventDefault()
        start = $this.get(0).selectionStart
        end = $this.get(0).selectionEnd

        # set textarea value to: text before caret + tab + text after caret
        $this.val($this.val().substring(0, start) +
                    '\t' +
                    $this.val().substring(end))

        # put caret at right position again
        $this.get(0).selectionStart =
        $this.get(0).selectionEnd = start + 1

      # enter key
      else if keyCode is 13
        val = $this.val()
        start = $this.get(0).selectionStart
        bl = val.lastIndexOf("\n", start-1)
        line = val.substring(bl, start)
        lm = line.match(/^\s+/)
        ns = if lm? then lm[0].length - 1 else 0
        nv = val.substring(0, start) + "\n"
        _(ns).times ->
          nv += "\t"
        $this.val(nv + val.substring(start))
        $this.get(0).selectionStart =
          $this.get(0).selectionEnd = start + ns + 1
        e.preventDefault()

    # new post tags
    $('#post_tags').select2 {
      tags: window.RV.AllTags
    }

    # Preview post.
    load_preview = ->
      text = $('#post_body').val()
      csrfToken = $("meta[name='csrf-token']").attr('content')
      $.post('/posts/preview.api', {
        'text': text
        'authenticity_token': csrfToken
      })
      .done (data) ->
        $('#post_preview').html(data)
        prettyPrint()

    $('#post_body').on('keyup mouseup', load_preview)

    load_preview()



