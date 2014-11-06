# Desc
#   フォームサイズの調整を自動で行う
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

    adjust = ->
      h = $window.height()
      settings.$editor.css('height', h - settings.height_offset)
      settings.$preview.css('height', h - settings.height_offset)

    adjust()

    $window.on 'resize', ->
      adjust()
