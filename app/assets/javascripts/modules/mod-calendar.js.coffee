# Desc
#   カレンダーにイベントを表示する
#   `.js-calendar`クラスのついた要素
# Usage:
# Example:

$ ->
  $('.js-calendar').each ->
    $this = $(@)
    $this.fullCalendar
      events: $this.data('eventsUrl') + '.json'
