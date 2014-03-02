# set debug method to window
# usage:
#   debug()(something)
#   And url must include '#debug' hash.
window.debug = ->
  if console? && console.debug? && location.hash is '#debug'
    return console.log.bind(console)
  else
    ->

