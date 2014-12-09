let bit = Bit.Zero

// a simple switch statement on an enum
switch bit {
case .Zero:
  println("zero")
case .One:
  println("one")
}

// interval matching
let time = 45
switch time {
case 0..<60:
  println("A few seconds ago")
case 60..<(60 * 4):
  println("A few minutes ago")
default:                 // default required in order
  println("Ages ago!")   // to be exhaustive
}

// tuples and value bindings
let boardLocation = (2, 5)
switch boardLocation {
case (3, 4), (3, 3), (4, 3), (4, 4):
  println("central location")
case (let x, let y):
  println("(\(x), \(y) is not in the center")
}
