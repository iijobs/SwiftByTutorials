// empty dictionary creation
let empty1 = [Int:String]()
let empty2 = Dictionary<Int, String>()
let empty3: [Int:String] = [:]

// a constant dictionary with inferred type
let animals = [24 : "cat", 36 : "dog"]
// animals[88] = "fish"   <- error!

// a variable dictionary with explicit type
var mutableAnimals: [Int:String] = [24 : "cat", 36 : "dog"]
mutableAnimals[55] = "fish"
mutableAnimals[24] = "chicken"

// dictionary API
animals[24]                 // "cat"
animals[1]                  // nil
animals.count               // "2"
mutableAnimals.removeValueForKey(24) // "chicken"

// dictionary values are returned as optionals
animals[24]!.hasPrefix("c") // true

// iteration
for (key, value) in animals {
  println(key)
  println(value)
}
