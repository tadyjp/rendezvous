window.debug = ->
  if console? && console.debug? && location.hash is '#debug'
    return console.log.bind(console)
  else
    ->

