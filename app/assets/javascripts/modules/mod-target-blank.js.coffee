# Desc
#   open link in newtab
# Usage:

$ ->
  $('a[href^=http]')
    .not('[href*="' + location.hostname + '"]')
    .attr({target:"_blank"})
