# Desc
#   フォームサイズ,スクロール位置の調整を自動で行う
# Usage:
#
# Example:
#

$.extend
  mod_form_resizer: (options) ->
    settings =
      $editor: null,
      $preview: null,
      height_offset: 0,
    settings = $.extend settings, options

    $window = $(window)
    editor_height = 0
    settings.$preview.css('overflow', 'scroll')

    # Set editor & preview height
    adjustHeight = ->
      h = $window.height()
      editor_height = h - settings.height_offset
      settings.$editor.css('height', editor_height)
      settings.$preview.css('height', editor_height)

    adjustHeight()

    $window.on 'resize', ->
      adjustHeight()

    # Set preview scrollTop by editor scrollTop
    adjustPreviewScroll = ->
      settings.$preview.prop('scrollHeight')
      editor_scrollTop = settings.$editor.scrollTop()
      preview_scrollHeight = settings.$preview.prop('scrollHeight')
      editor_scrollHeight = settings.$editor.prop('scrollHeight')

      preview_scrollTop = (preview_scrollHeight - editor_height) / (editor_scrollHeight - editor_height) * editor_scrollTop
      settings.$preview.scrollTop(preview_scrollTop)

      console.log([editor_scrollTop, preview_scrollHeight, editor_height, editor_scrollHeight, preview_scrollTop])

    settings.$editor.on 'scroll', _.throttle(adjustPreviewScroll, 1000 / 30)

