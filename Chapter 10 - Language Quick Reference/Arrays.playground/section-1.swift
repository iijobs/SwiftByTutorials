import Foundation

// empty array creation
let empty1 = [String]()
let empty2 = Array<String>()
let empty3: [String] = []

// a constant array with inferred type
let animals = ["cat", "dog", "chicken"]
// animals.append("cow")  <- error!
// animals[2] = "fish"    <- error!

// a variable array with explicit type
var mutableAnimals: [String] = ["cat", "dog", "chicken"]
mutableAnimals.append("cow")
mutableAnimals[2] = "fish"

// iteration
for animal in animals {
  println(animal)
}

// array API
animals[0]                      // "cat"
animals[1..<3]                  // "dog", "chicken"
animals.count                   // "3"
contains(animals, "cat")        // true
mutableAnimals.removeAtIndex(0) // "cat"

// functional API
animals.map { $0.uppercaseString }   // "CAT", "DOG", ...
animals.filter { $0.hasPrefix("c") } // "cat", "chicken"
animals.sorted { $0 < $1 }           // "cat", "chicken", ...

// bridged NSArray API
let nsArray = animals as NSArray
nsArray.objectAtIndex(2)        // "chicken"



