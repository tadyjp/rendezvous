# TODO:
#   mod-mdEditorがページ内に複数あった場合の処理

$.fn.extend
  mod_mdEditor: (options) ->
    settings =
      # preview api url
      end_point: ''
    settings = $.extend settings, options

    return @each ()->

      $root = $(@)

      # Automaticaly change textarea height.
      $root.find('.mod-mdEditor-body').autosize();

      # disable tab key
      $root.find('.mod-mdEditor-body').on 'keydown', (e) ->
        $this = $(@)

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

      # タグを選択可能に
      $root.find('.mod-mdEditor-tags').select2 {
        tags: window.RV.AllTags
      }

      # Previewを生成
      generatePreview = ->
        $.post(settings.end_point, {
          'text': $root.find('.mod-mdEditor-body').val()
          'authenticity_token': $("meta[name='csrf-token']").attr('content')
        })
        .done (data) ->
          $root.find('.mod-mdEditor-preview').html(data)

          # TODO
          prettyPrint()

      $('.mod-mdEditor-body').on('keyup mouseup change', generatePreview)

      generatePreview()



