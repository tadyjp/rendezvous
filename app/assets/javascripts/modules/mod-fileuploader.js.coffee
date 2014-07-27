$.extend
  mod_fileuploader: (options) ->
    settings =
      $input: null,
      $textarea: null,
      $progressWrapper: null,
      $progressBar: null
    settings = $.extend settings, options

    # Used for replacing text
    uploadingIndex = 0

    settings.$input.fileupload
      dataType: 'json'

      add: (e, data) ->
        settings.$progressWrapper.show()
        settings.$textarea.val(settings.$textarea.val() + "\n[Uploading... #" + uploadingIndex + "]\n")

        data.formData = { uploading_index: uploadingIndex }
        data.submit()
        uploadingIndex += 1

      done: (e, data) ->
        settings.$progressWrapper.hide()

        $.each data.result.files, (index, file) ->
          # TODO: カーソル位置に挿入

          textarea_value = settings.$textarea.val()

          if file.type is 'image'
            # ![file-name](file-url)
            replacing_text = "![" + file.name + "](" + file.image + ")"
            new_textarea_value = textarea_value.replace('[Uploading... #' + data.result.uploading_index + ']', replacing_text)
            settings.$textarea.val(new_textarea_value)
          else if file.type is 'slide'
            # [![alt text](image link)](web link)
            replacing_text = "[![" + file.name + "](" + file.image + ")](" + file.url + ")"
            new_textarea_value = textarea_value.replace('[Uploading... #' + data.result.uploading_index + ']', replacing_text)
            settings.$textarea.val(new_textarea_value)

          settings.$textarea.trigger("change")
          # $('<p/>').text(file.name).appendTo('#files') # TODO
      progressall: (e, data) ->
        progress = parseInt(data.loaded / data.total * 100, 10)
        settings.$progressBar
          .css(width: progress + '%')
          .text(progress + '%')


    settings.$input.prop('disabled', !$.support.fileInput)
      .parent().addClass($.support.fileInput ? undefined : 'disabled');

    $('<p id="mod-fileuploader-notify"/>').text('ここにドロップしてください').appendTo('body')

    $(window).bind 'dragover', (e) ->
      $('#mod-fileuploader-notify').show()
    # $(window).bind 'dragleave', (e) ->
    #   console.log('dragleave')
    #   $('#mod-fileuploader-notify').hide()
    $(window).bind 'dragend', (e) ->
      $('#mod-fileuploader-notify').hide()
    $(window).bind 'drop', (e) ->
      $('#mod-fileuploader-notify').hide()

