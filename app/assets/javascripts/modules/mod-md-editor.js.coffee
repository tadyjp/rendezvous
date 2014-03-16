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
      $textarea = $root.find('.mod-mdEditor-textarea')

      # textareのサイズ調整
      $textarea.autosize();

      # textareaのtabキー制御,indent維持
      $textarea.on 'keydown', (e) ->
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
          e.preventDefault()

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

      # タグを選択可能に
      $root.find('.mod-mdEditor-tags').select2 {
        tags: window.RV.AllTags
      }

      # Previewを生成
      generatePreview = ->
        $.post(settings.end_point, {
          'text': $textarea.val()
          'authenticity_token': $("meta[name='csrf-token']").attr('content')
        })
        .done (data) ->
          $root.find('.mod-mdEditor-preview').html(data)

          # TODO
          prettyPrint()

      $textarea.on('keyup mouseup change', generatePreview)

      generatePreview()

      # textの行数をcount
      count_line_number = (text) ->
        matches = text.match(/\n/g)
        if matches? then matches.length + 1 else 1

      replace_regexp_meta = (str) ->
        str.replace(/([\.\^\$\[\]\*\+\?\|\(\)])/g, "\\$1")

      # 行の先頭に文字を挿入
      md_head_insert_string = (insert_str) ->
        textarea_text = $textarea.val()



        sel_start_pos = $textarea.get(0).selectionStart

        # sel_end_pos = $textarea.get(0).selectionEnd


        # # textの全行数
        # line_num = count_line_number(textarea_text)


        # # 現在行の行数
        # current_line_num = count_line_number(textarea_text.substr(0, sel_start_pos))


        # 現在行の最初の文字の位置
        current_line_head_pos = textarea_text.lastIndexOf("\n", sel_start_pos - 1) + 1


        # 現在行のカーソル位置
        current_pos_in_line = sel_start_pos - current_line_head_pos


        # すでに挿入済みの場合は取り除く
        insert_str_re = new RegExp('^' + replace_regexp_meta(insert_str), "g") # TODO ?
        if textarea_text.substring(current_line_head_pos).match(insert_str_re)
          $textarea.val([
            textarea_text.substring(0, current_line_head_pos),
            textarea_text.substring(current_line_head_pos).replace(insert_str_re, '')
          ].join(''))

        else
          $textarea.val([
            textarea_text.substring(0, current_line_head_pos),
            insert_str,
            textarea_text.substring(current_line_head_pos)
          ].join(''))

      # 選択文字を囲う
      md_wrap_string = (wrap_str) ->
        textarea_text = $textarea.val()

        sel_start_pos = $textarea.get(0).selectionStart
        sel_end_pos = $textarea.get(0).selectionEnd

        # 文字が選択されていなければplaceholderを挿入
        if sel_start_pos == sel_end_pos
          placeholder_str = '<ここに文字>'
          $textarea.val([
            textarea_text.substring(0, sel_start_pos),
            placeholder_str,
            textarea_text.substring(sel_end_pos)
          ].join(''))
          $textarea.get(0).selectionEnd = sel_end_pos + 2 + 2 * wrap_str.length + placeholder_str.length


          # execute self.
          md_wrap_string(wrap_str)
          return


        # すでに挿入済みの場合は取り除く
        wrap_str_re = new RegExp('^ ' + replace_regexp_meta(wrap_str))

        wrap_str_re_end = new RegExp(replace_regexp_meta(wrap_str) + ' $')
        if textarea_text.substring(sel_start_pos, sel_end_pos).match(wrap_str_re)

          $textarea.val([
            textarea_text.substring(0, sel_start_pos),
            textarea_text.substring(sel_start_pos, sel_end_pos).
              replace(wrap_str_re, '').
              replace(wrap_str_re_end, ''),
            textarea_text.substring(sel_end_pos)
          ].join(''))
        else
          $textarea.val([
            textarea_text.substring(0, sel_start_pos),
            ' ',
            wrap_str,
            textarea_text.substring(sel_start_pos, sel_end_pos),
            wrap_str,
            ' ',
            textarea_text.substring(sel_end_pos)
          ].join(''))

        # カーソルの終了位置を移動
        $textarea.get(0).selectionEnd = sel_end_pos + 2 + 2 * wrap_str.length

        $textarea.get(0).selectionStart = sel_start_pos


      # WYSIWYG
      $root.find('.mod-mdEditor-btn-h1').on 'click', (e) ->
        e.preventDefault()
        md_head_insert_string('# ')
        generatePreview()

      $root.find('.mod-mdEditor-btn-h2').on 'click', (e) ->
        e.preventDefault()
        md_head_insert_string('## ')
        generatePreview()

      $root.find('.mod-mdEditor-btn-h3').on 'click', (e) ->
        e.preventDefault()
        md_head_insert_string('### ')
        generatePreview()

      $root.find('.mod-mdEditor-btn-ol').on 'click', (e) ->
        e.preventDefault()
        md_head_insert_string('1. ')
        generatePreview()

      $root.find('.mod-mdEditor-btn-ul').on 'click', (e) ->
        e.preventDefault()
        md_head_insert_string('- ')
        generatePreview()

      $root.find('.mod-mdEditor-btn-bold').on 'click', (e) ->
        e.preventDefault()
        md_wrap_string('**')
        generatePreview()

      $root.find('.mod-mdEditor-btn-italic').on 'click', (e) ->
        e.preventDefault()
        md_wrap_string('_')
        generatePreview()

      $root.find('.mod-mdEditor-btn-strikethrough').on 'click', (e) ->
        e.preventDefault()
        md_wrap_string('~~')
        generatePreview()


