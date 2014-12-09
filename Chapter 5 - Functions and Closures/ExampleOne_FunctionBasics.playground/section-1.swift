import Foundation

// returns the square of a number
func square(number: Double) -> Double {
  return number * number
}

// assigns the square function to a constant
let operation:(Double) -> Double = square;

// computes a pythagorean triple
let a = 3.0, b = 4.0
let c = sqrt(operation(a) + operation(b))
println(c)

// a function for logging doubles with a fixed precision
func logDouble(number:Double) {
  println(String(format: "%.2f", number))
}

var logger:(Double) -> () = logDouble
logger(c)
