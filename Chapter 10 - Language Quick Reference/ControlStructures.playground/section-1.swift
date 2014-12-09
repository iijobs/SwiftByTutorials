
for index in 1..<3 {
  // loops with index taking values 1,2
}

for index in 1...3 {
  // loops with index taking values 1,2,3
}

for index in stride(from: 10, through: 20, by: 2){
  // loops form 10 to 20 (inclusive) in steps of 2
}

var index = 0
while index < 5 {
  // loops 5 times
  index++
}

index = 0
do {
  // loops 5 times
  index++
} while index < 5

// if/else
let temperature = 45
if temperature > 60 {
  println("It's hot!")
} else if temperature > 40 {
  println("It's warm")
} else {
  println("It's chilly")
}
