// Playground - noun: a place where people can play
import Foundation

let words = ["Cat", "Chicken", "fish", "Dog", "Mouse", "Guinea Pig", "monkey"]

typealias Entry = (Character, [String])

func buildIndex(words: [String]) -> [Entry] {  var result = [Entry]()    var letters = [Character]()  for word in words {    let firstLetter = Character(word.substringToIndex(      advance(word.startIndex, 1)).uppercaseString)        if !contains(letters, firstLetter) {      letters.append(firstLetter)    }  }
        for letter in letters {    var wordsForLetter = [String]()    for word in words {      let firstLetter = Character(word.substringToIndex(        advance(word.startIndex, 1)).uppercaseString)          if firstLetter == letter {        wordsForLetter.append(word)      }    }    result.append((letter, wordsForLetter))  }  return result}

println(buildIndex(words))
