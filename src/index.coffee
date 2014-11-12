curry = require "curry"

ensureObj = (obj) ->
  throw new TypeError "Value #{obj} is not an object." unless Object(obj) is obj

map = (cb, obj) ->
  ensureObj obj
  if Array.isArray obj
    return (cb item, i for item, i in obj)
  else
    result = {}
    result[key] = cb obj[key], key for key in Object.keys obj
    result

each = (cb, obj) ->
  map obj, cb
  undefined

filter = (cb, obj) ->
  ensureObj obj
  if Array.isArray obj
    return (item for item, i in obj when cb item, i)
  else
    result = {}
    result[key] = value for key, value in Object.keys obj when cb key, value
    result

reduce = (cb, result, obj) ->
  ensureObj obj
  arr = if Array.isArray obj then obj else Object.keys obj
  result = cb result, obj[key], key for key in arr
  result

module.exports =
  map: curry map
  each: curry each
  filter: curry filter
  reduce: curry reduce