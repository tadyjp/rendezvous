
# namespace
RV.tools = {}

# get url parameter and parse.
# ex.) /?a=b&c=123  ==>  {"a": "b", "c": "123"}
RV.tools.getQueryParams = ->
  query = window.location.search.split("+").join(" ")
  params = {}
  re = /[?&]?([^=]+)=([^&]*)/g
  dc = decodeURIComponent
  while (tokens = re.exec(query))
    params[dc(tokens[1])] = dc(tokens[2])

  return params
