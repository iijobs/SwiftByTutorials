struct Person {
  var age = 34, name = "Colin"
  
  mutating func growOlder() {
    self.age++
  }
}

func celebrateBirthday(inout cumpleañero: Person) {
  println("Happy Birthday \(cumpleañero.name)")
  cumpleañero.growOlder()
}

var person = Person()
celebrateBirthday(&person)
println(person.age)
