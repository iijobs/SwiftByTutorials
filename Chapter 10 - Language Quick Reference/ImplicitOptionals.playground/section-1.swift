// an implicitely unwrapped optional variable
var maybeString: String!
maybeString = nil
maybeString = "fish"

// methods invoked directly, failing at runtime if the optional is nil
if maybeString.hasPrefix("f") {
  println("maybeString starts with 'f'")
}else {
  println("maybeString does not start with an 'f'")
}
