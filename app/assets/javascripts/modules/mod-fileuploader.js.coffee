$.extend
  mod_fileuploader: (options) ->
    settings =
      $input: null,
      $textarea: null
    settings = $.extend settings, options

    settings.$input.fileupload
      dataType: 'json'
      done: (e, data) ->
        $.each data.result.files, (index, file) ->
          # TODO: カーソル位置に挿入

          if file.type is 'image'
            # image ![file-name](file-url)
            settings.$textarea.val(settings.$textarea.val() + "\n![" + file.name + "](" + file.url + ")\n")
          else if file.type is 'slide'
            # slide !slide!(file-url)
            settings.$textarea.val(settings.$textarea.val() + "\n!slide!(" + file.url + ")\n")

          settings.$textarea.trigger("change")
          # $('<p/>').text(file.name).appendTo('#files') # TODO
      # progressall: (e, data) ->
      #   progress = parseInt(data.loaded / data.total * 100, 10)
      #   $('.progress-bar').css
      #     width: progress + '%'

    settings.$input.prop('disabled', !$.support.fileInput)
      .parent().addClass($.support.fileInput ? undefined : 'disabled');

    $('<p id="mod-fileuploader-notify"/>').text('ここにドロップしてください').appendTo('body')

    $(window).bind 'dragover', (e) ->
      console.log('dragover')
      $('#mod-fileuploader-notify').show()
    # $(window).bind 'dragleave', (e) ->
    #   console.log('dragleave')
    #   $('#mod-fileuploader-notify').hide()
    $(window).bind 'dragend', (e) ->
      console.log('dragend')
      $('#mod-fileuploader-notify').hide()
    $(window).bind 'drop', (e) ->
      console.log('drop')
      $('#mod-fileuploader-notify').hide()

