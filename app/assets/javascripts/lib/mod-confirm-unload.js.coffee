# Desc
#   ページから離脱するときに確認画面を出す
#   `.js-disable-confirm-unload`クラスのついた要素をクリックした時に無効にする
# Usage:
#   $.setConfirmUnload()

$.extend
  setConfirmUnload: ->

    confirmUnload = ->
      return 'このページを離れますか？'
    $(window).on('beforeunload', confirmUnload)

    $('.js-disable-confirm-unload').on 'click', ->
      $(window).off('beforeunload', confirmUnload)

    return @
