// enum declaration
enum Direction {
  case North, South, East, West
}

// assignment
var direction = Direction.North
direction = .South   // enum type inferred

// switching on enums
switch direction {
case .North:
  println("Going North")
default:
  println("Going someplace else!")
}

// advanced enumerations - using generics
enum Result<T> {
  case Failure
  // enumeration member with associated value
  case Success(T)
}

// creating an instance - where the type T is an Int
var result = Result.Success(22)

// switching and extracting the associated value
switch result {
case .Failure:
  println("Operation failed")
case .Success(let value):
  println("Operation returned value \(value)")
}
