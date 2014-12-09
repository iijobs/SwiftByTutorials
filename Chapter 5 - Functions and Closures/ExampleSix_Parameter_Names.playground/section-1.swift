
func checkAreEqual(#value: String, #expected: String, #message: String) {
  if expected != value {
    println(message)
  }
}

checkAreEqual(value: "dog", expected: "cat",
  message:"Incorrect input")


