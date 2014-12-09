// a simple function
func voidFunc(message: String) {
  println(message);
}
voidFunc("Hello Swift!")

// a function that returns a value
func multiply(arg1: Double, arg2: Double) -> Double {
  return arg1 * arg2
}
let result = multiply(20.0, 35.2)

// external and default parameters names
func multiplyTwo(#first: Double, andSecond second: Double) -> Double {
  return first * second
}
let result2 = multiplyTwo(first: 20.0, andSecond: 35.2)

// inout parameters
func square(inout number: Double) {
  number *= number
}
var number = 4.0
square(&number) // number = 16

// function types
let myFunc: (Double, Double) -> Double = multiplyTwo

// a generic function
func areEqual<T: Equatable>(op1: T, op2: T) -> Bool {
  return op1 == op2
}

