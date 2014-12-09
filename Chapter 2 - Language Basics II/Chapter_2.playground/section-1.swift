/*
* Copyright (c) 2014 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

var str: String!
println(str)

if let unwrappedStr = str {
  println("Unwrapped! \(unwrappedStr.uppercaseString)")
} else {
  println("Was nil")
}

if str != nil {
  str = str.lowercaseString
  println(str)
}

var maybeString: String? = "Hello Swift by Tutorials!"
let uppercase = maybeString?.uppercaseString

var array: [Int] = [1, 2, 3, 4, 5]
println(array[2])
array.append(6)
array.extend(7...10)
println(array)

// Challenge solution:
array.removeAtIndex(8)
array.removeAtIndex(6)
array.removeAtIndex(4)
array.removeAtIndex(2)
array.removeAtIndex(0)
println(array)

// Challenge solution:
var anyArray: [AnyObject] = []
anyArray.append(1)
anyArray.append("1")
println(anyArray)

var dictionary: [Int:String] = [1: "Dog", 2: "Cat"]
println(dictionary[1])
dictionary[3] = "Mouse"
dictionary[3] = nil
println(dictionary)

// Challenge solution:
dictionary.updateValue("Elephant", forKey: 2)
println(dictionary)

println(dictionary[1])

if let value = dictionary[1] {
  println("Value is \(value)")
}

var dictionaryA = [1: 1, 2: 4, 3: 9, 4: 16]
var dictionaryB = dictionaryA
println(dictionaryA)
println(dictionaryB)

dictionaryB[4] = nil
println(dictionaryA)
println(dictionaryB)

var arrayA = [1, 2, 3, 4, 5]
var arrayB = arrayA
println(arrayA)
println(arrayB)

arrayB[0] = 10
println(arrayA)
println(arrayB)

let constantArray = [1, 2, 3, 4, 5]
//constantArray.append(6)//constantArray.removeAtIndex(0)

// Challenge solution:
let constantDictionary: [Int:String] = [1: "One", 2: "Two", 3: "Three"]
//constantDictionary.updateValue("Four", forKey: 4) ///< Errors when uncommented
