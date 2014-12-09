
func checkAreEqual<T: Equatable>(value: T, expected: T, message: String) {
  if expected != value {
    println(message)
  }
}


var input = 3
checkAreEqual(input, 2, "An input value of '2' was expected")

input = 47
checkAreEqual(input, 47, "An input value of '47' was expected")

var inString = "cat"
checkAreEqual(inString, "dog",
  "An input value of 'dog' was expected")


