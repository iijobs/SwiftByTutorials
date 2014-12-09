import Foundation

let words = ["Cat", "Chicken", "fish", "Dog", "Mouse", "Guinea Pig", "monkey"]

typealias Entry = (Character, [String])

func distinct<T: Equatable>(source: [T]) -> [T] {
  var unique = [T]()
  for item in source {
    if !contains(unique, item) {
      unique.append(item)
    }
  }
  return unique
}

func buildIndex(words: [String]) -> [Entry] {
  
  func firstLetter(str: String) -> Character {
    return Character(str.substringToIndex(      advance(str.startIndex, 1)).uppercaseString)
  }
  
  return distinct(words.map(firstLetter))
    .map {
      (letter) -> Entry in
      return (letter, words.filter {
        (word) -> Bool in
        firstLetter(word) == letter
      })
    }
}

println(buildIndex(words))

