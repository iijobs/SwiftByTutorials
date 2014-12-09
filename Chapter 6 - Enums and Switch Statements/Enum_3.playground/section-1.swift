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

enum Shape {
  case Rectangle(width: Float, height: Float)
  case Square(side: Float)
  case Triangle(base: Float, height: Float)
  case Circle(radius: Float)
}

var rectangle = Shape.Rectangle(width: 5, height: 10)
var triangle = Shape.Triangle(base: 5, height: 10)

switch (rectangle) {
case .Triangle(let base, let height) where height > 10:
  println("Tall triangle: \(base) x \(height)")
case .Triangle(let base, let height) where height == base * 2:
  println("Triangle which is twice as tall as its base: \(base) x \(height)")
case .Circle(let radius) where radius < 5:
  println("Small circle: \(radius)")
case .Rectangle(let width, let height):
  println("Wide rectangle: \(width) x \(height)")
case .Rectangle(let width, let height) where width == height:
  println("Square: \(width) x \(height)")
case .Square(let side):
  println("Square: \(side) x \(side)")
case .Rectangle(let width, let height) where width <= 10:
  println("Narrow rectangle: \(width) x \(height)")
default:
  println("Other shape")
}
