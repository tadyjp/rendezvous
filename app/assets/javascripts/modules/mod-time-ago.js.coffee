# Desc
#   nn分前をjsで表示する
#   `.js-time-ago`クラスのついた要素の`data-time-ago-at`属性を時刻に変換
# Usage:
#   <abbr class="js-time-ago" data-time-ago-at="2014-03-12 00:27:57 +0900"></abbr>
# Example:
#   <abbr class="js-time-ago" data-time-ago-at="2014-03-12 00:27:57 +0900">a minute ago</abbr>

$ ->
  renderTimeAgo = ->
    $('.js-time-ago').each ->
      $this = $(@)
      $this.text moment($this.data('time-ago-at')).fromNow()

  setInterval(renderTimeAgo, 1000 * 10)
  renderTimeAgo()
