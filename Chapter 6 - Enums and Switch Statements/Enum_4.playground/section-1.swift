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
  
  func area() -> Float {
    switch(self) {
    case .Rectangle(let width, let height):
      return width * height
    case .Square(let side):
      return side * side
    case .Triangle(let base, let height):
      return 0.5 * base * height
    case .Circle(let radius):
      return Float(M_PI) * powf(radius, 2)
    }
  }
  
  init(_ rect: CGRect) {
    let width = Float(CGRectGetWidth(rect))
    let height = Float(CGRectGetHeight(rect))
    if width == height {
      self = Square(side: width)
    } else {
      self = Rectangle(width: width, height: height)
    }
  }
  
  static func fromString(string: String) -> Shape? {    switch(string) {    case "rectangle":      return Rectangle(width: 5, height: 10)    case "square":      return Square(side: 5)    case "triangle":      return Triangle(base: 5, height: 10)    case "circle":      return Circle(radius: 5)    default:      return nil    }  }
}

var circle = Shape.Circle(radius: 5)
circle.area()

var shape = Shape(CGRectMake(0, 0, 5, 10))
shape.area()

//if let anotherShape = Shape.fromString("rectangle") {
//    anotherShape.area()
//}
