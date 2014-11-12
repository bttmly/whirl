curry = require "curry"

typeCheck = (cb, obj) ->
  throw new TypeError "Value #{cb} is not a function." unless typeof cb is "function"
  throw new TypeError "Value #{obj} is not an object." unless Object(obj) is obj

map = (cb, obj) ->
  typeCheck cb, obj
  if Array.isArray obj
    return (cb item, i for item, i in obj)
  else
    result = {}
    result[key] = cb obj[key], key for key in Object.keys obj
    result

each = (cb, obj) ->
  map cb, obj
  return undefined

filter = (cb, obj) ->
  typeCheck cb, obj
  if Array.isArray obj
    return (item for item, i in obj when cb item, i)
  else
    result = {}
    result[key] = obj[key] for key in Object.keys obj when cb key, obj[key]
    result

reduce = (cb, result, obj) ->
  typeCheck cb, obj
  keys = 
    if Array.isArray obj
      map ((_, i) -> i), obj
    else 
      Object.keys obj
  result = result(obj) if typeof result is "function"
  result = cb(result, obj[key], key) for key in keys
  result

module.exports =
  map: curry map
  each: curry each
  filter: curry filter
  reduce: curry reduce