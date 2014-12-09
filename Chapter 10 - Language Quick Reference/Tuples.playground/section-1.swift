let tuple = (1, 3, 5)   // inferred type (Int, Int, Int)
let tuple2 = (1, 5.0)   // inferred type (Int, Double)
let tuple3: (Double, Double) = (5, 6)

// indexing a tuple
println(tuple.0)
println(tuple.1)
println(tuple.2)

// a tuple with named elements
let product = (id: 24, name: "Swift Book")
println(product.name)

// decomposing a tuple
let (x, y, z) = tuple
println("\(x), \(y), \(z)") // "1, 3, 5"