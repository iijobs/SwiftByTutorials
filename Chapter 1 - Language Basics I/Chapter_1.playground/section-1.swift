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

import Foundation

// Strings
var hello = "Hello"
hello = hello + " World"
println(hello)

var alternateGreeting = hello
alternateGreeting += " and beyond!"
println(alternateGreeting)
println(hello)

// Numeric types and conversion
var radius = 4
let pi = 3.14159
var area = Double(radius) * Double(radius) * pi

// Booleans
let alwaysTrue = true

// Tuples
var address = (number: 742, street: "Evergreen Terrace")

println(address.number)
println(address.street)

println(address.0)
println(address.1)

let (house, street) = address
println(house)
println(street)

// String interpolation
println("I live at \(house), \(street)")
let str = "I live at \(house + 10), \(street.uppercaseString)"
println(str)

// For loops and ranges
let greeting = "Swift by Tutorials Rocks!"

var range = 1...5
for i in range {
  println("\(i) - \(greeting)")
}

// While loops
var i = 0
while i < 5 {
  println("\(i) - \(greeting)")
  i++
}

// If statements
for i in 1...5 {
  if i == 5 {
    println(greeting.uppercaseString)
  } else {
    println(greeting)
  }
}

// Switch statements
var direction = "up"

switch direction {
case "down":
  println("Going Down!")
case "up":
  println("Going Up!")
default:
  println("Going Nowhere")
}

var score = 570

var prefix: String
switch score {
case 1..<10:
  println("novice")
case 10..<100:
  println("proficient")
case 100..<1000:
  println("rock-star")
default:
  println("awesome")
}
