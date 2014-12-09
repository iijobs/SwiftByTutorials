let animals = ["fish", "cat", "chicken", "dog"]

var isBefore = {    (one: String, two: String) -> Bool in  return one > two}let sortedStrings = animals.sorted(isBefore)

let sortedStrings2 = animals.sorted { $0 > $1 }

let sortedStrings3 = animals.sorted(>)

