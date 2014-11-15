# whirl [![Build Status](https://travis-ci.org/nickb1080/whirl.svg?branch=master)](https://travis-ci.org/nickb1080/whirl)

Curried, object-accepting, data-last versions of `map`, `each`, `filter` and `reduce`. 

### Methods

#### `**map**(Function **callback**, Object | Array **data**) => Array | Object`
`map()` invokes an operation once on each itm in a collection, and collects the return values in a collection of the same type (i.e. mapping an array produces an array, likewise for objects).

**Array**
`callback(Any value, Number index)`

**Object**
`callback(Any value, String key)`


#### `each(Function callback, Object | Array data) => Array | Object`
`each()` invokes an operation once on each item in a collection and returns `undefined`.

**Array**
`callback(Any value, Number index)`

**Object**
`callback(Any value, String key)`

#### `filter(Function callback, Object | Array data) => Array | Object`
`filter()` invokes an operation on each item in a collection, collecting the items (not return values) for which the operation returns a truthy value. Results are of same type as input.

**Array**
`callback(Any value, Number index)`

**Object**
`callback(Any value, String key)`

#### `reduce(Function callback, Any initial, Object | Array data) => Any`
`reduce()` invokes an operation on each item in a collection, with the first argument being the `accumulator`, which is set to the result of the operation, and passed to the next invocation. Results are of a type determined by the operation.

**Array**
`callback(Any current, Any value, Number index)`

**Object**
`callback(Any current, Any value, String key)`