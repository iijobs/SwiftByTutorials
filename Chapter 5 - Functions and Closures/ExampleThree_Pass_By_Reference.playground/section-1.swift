import Foundation

func square(inout number: Double) {
  number = number * number
}

var a = 2.0
square(&a)
println(a)





