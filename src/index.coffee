curry = require "curry"
fastMap = require "fast.js/map"
fastEach = require "fast.js/forEach"
fastFilter = require "fast.js/filter"
fastReduce = require "fast.js/reduce"

typeCheck = (cb, obj) ->
  m = []
  m.push("Value #{cb} is not a function.") unless typeof cb is "function"
  m.push("Value #{obj} is not an object.") unless Object(obj) is obj
  throw new TypeError m.join "\n" if m.length

# doing thisContext this way ensures currying works as expected (context is optional)
# and that it is performant under V8 per (argument optimization)
map = (cb, obj) ->
  typeCheck cb, obj
  thisContext = arguments[2] if arguments.length > 2
  return if thisContext
    fastMap obj, cb, thisContext
  else
    fastMap obj, cb

each = (cb, obj) ->
  map cb, obj
  return undefined

filter = (cb, obj) ->
  typeCheck cb, obj
  thisContext = arguments[2] if arguments.length > 2
  return if thisContext
    fastFilter obj, cb, thisContext
  else
    fastFilter obj, cb

reduce = (cb, initial, obj) ->
  typeCheck cb, obj
  thisContext = arguments[3] if arguments.length > 3
  # allow currying with initial-creating functions such as (-> {} or Array constructor)
  # initial-creating functions shouldn't need arguments, that's what reduce is for anyway
  initial = do initial if typeof initial is "function"
  return if thisContext
    fastReduce obj, cb, initial, thisContext
  else
    fastReduce obj, cb, initial

module.exports =
  map: curry map
  each: curry each
  filter: curry filter
  reduce: curry reduce
