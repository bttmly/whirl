should = require("chai").should()

partial = (fn, args...) ->
  (more...) ->
    fn.apply @, args.concat more

{map, each, filter, reduce} = require "../src/index.coffee"

arr = undefined
obj = undefined

sum = (a, b) -> a + b

is_odd = (n) -> n % 2

beforeEach ->
  arr = [1, 2, 3]
  obj =
    key1: "value1"
    key2: "value2"
    key3: "value3"

describe "currying", ->
  describe "all functions are curried", ->
    it "map", ->
      map(sum).should.be.a "function"
      map(sum)(arr).should.be.an "array"

    it "each", ->
      each(sum).should.be.a "function"
      should.not.exist each(sum)(arr)

    it "filter", ->
      filter(is_odd).should.be.a "function"
      filter(is_odd)(arr).should.be.an "array"

    it "reduce", ->
      reduce(sum).should.be.a "function"
      reduce(sum, 0).should.be.a "function"
      reduce(sum, 0, arr).should.be.a "number"


describe "type checking", ->
  # todo check err messages in throw
  it "map", ->
    partial(map, "a", "b").should.throw()
    partial(map, "c", arr).should.throw()
    partial(map, sum, "d").should.throw()
    partial(map, sum, arr).should.not.throw()

  it "each", ->
    partial(each, "e", "f").should.throw()
    partial(each, "g", arr).should.throw()
    partial(each, sum, "h").should.throw()
    partial(each, sum, arr).should.not.throw()

  it "filter", ->
    partial(filter, "i", "j").should.throw()
    partial(filter, "k", arr).should.throw()
    partial(filter, sum, "l").should.throw()
    partial(filter, sum, arr).should.not.throw()

  it "reduce", ->
    partial(reduce, "m", null, "n").should.throw()
    partial(reduce, "o", null, arr).should.throw()
    partial(reduce, sum, null, "p").should.throw()
    partial(reduce, sum, null, arr).should.not.throw()


describe "#map", ->

  describe "curried", ->
    it "is curried", ->
      map(sum).should.be.a "function"
      map(sum)(arr).should.be.an "array"
      map(sum, arr).should.be.an "array"

  describe "array", ->
    it "maps an array", ->
      result = map sum, arr
      result.should.deep.equal [1, 3, 5]

  describe "object", ->
    it "maps an object", ->
      result = map sum, obj
      result.should.deep.equal 
        key1: "value1key1"
        key2: "value2key2"
        key3: "value3key3"




describe "#each", ->

  concat_key = undefined
  concat_val = undefined
  counter = undefined
  add_val = (val) -> 
    counter += val
  add_key = (_, key) ->
    counter += key


  beforeEach ->
    counter = 0
    concat_val = do ->
      str = ""
      (val) -> 
        if val
          str += val
          undefined
        else
          str
    concat_key = do ->
      str = ""
      (_, key) -> 
        if key
          str += key
          undefined
        else
          str

  describe "array", ->
    it "each's an array", ->
      each(add_val, arr)
      # 1 + 2 + 3
      counter.should.equal 6
      each(add_key, arr)
      # 6 + 0 + 1 + 2
      counter.should.equal 9

  describe "object", ->
    it "each's an object", ->
      each(concat_key, obj)
      concat_key().should.equal "key1key2key3"
      each(concat_val, obj)
      concat_val().should.equal "value1value2value3"




describe "#filter", ->

  describe "curried", ->
    it "is curried", ->


  describe "array", ->
    it "filters an array", ->
      filter(is_odd, arr).should.deep.equal [1, 3]

  describe "object", ->
    it "filters an object", ->
      (filter (value, key) ->
        key.indexOf(2) isnt -1 or value.indexOf(3) isnt -1
      , obj).should.deep.equal key2: "value2", key3: "value3"




describe "#reduce", ->

  describe "array", ->
    it "reduces an array", ->
      reduce(sum, 0, arr).should.equal 6


  describe "object", ->
