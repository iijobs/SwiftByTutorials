
class Cell: Printable {
  
  private(set) var row = 0
  private(set) var column = 0
  
  func moveByX(x: Int, y: Int) {
    row += y
    column += x
  }
  
  func moveByX(x: Int) {
    column += x
  }
  
  func moveByY(y: Int) {
    row += y
  }
  
  var description: String {
    get {
      return "Cell [row=\(row), col=\(column)]"
    }
  }
}

var cell = Cell()
var moveFunc = Cell.moveByY
moveFunc(cell)(34)
println(cell.description)



