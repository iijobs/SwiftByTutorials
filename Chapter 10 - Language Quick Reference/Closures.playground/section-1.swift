let animals = ["fish", "cat" , "chicken", "dog"]

animals.sorted({
  (one: String, two: String) -> Bool in
  return one > two
})

animals.sorted({
  (one, two) -> Bool in // inferred argument types
  return one > two
})

animals.sorted({
  (one, two) in        // inferred return type
  return one > two
})

animals.sorted({
  // no brackets around parameters
  one, two in return one > two
})

animals.sorted({
  // no return keyword
  one, two in one > two
})

// shorthand arguments
animals.sorted({ $0 > $1 })

// trailing closure
animals.sorted() { $0 > $1 }
animals.sorted { $0 > $1 }