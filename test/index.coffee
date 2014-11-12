should = require("chai").should()

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

  counter = 0
  add_counter = (num) -> 
    counter += num

  beforeEach ->
    counter = 0

  describe "curried", ->
    it "is curried", ->
      each(add_counter).should.be.a "function"
      should.not.exist each(add_counter)(arr)
      should.not.exist each(add_counter, arr)

  describe "array", ->

  describe "object", ->




describe "#filter", ->

  describe "array", ->
    it "filters an array", ->
      filter(is_odd, arr).should.deep.equal [1, 3]

  describe "object", ->
    it "filters an object", ->
      (filter (value, key) ->
        key.indexOf(2) isnt -1
      , obj).should.deep.equal key2: "value2"



describe "#reduce", ->

  describe "array", ->

  describe "object", ->
