public class BaseClass {
  private let id: Int            // private constant property
  
  init(id: Int) {
    self.id = id
  }
    
    class func numberOfLegs() ->Int {
    return 4;
    }
}

protocol NamedType {
  var name: String { get }       // a property with a getter
}

public class Animal: BaseClass, NamedType {
  
  private(set) var name: String  // variable with public getter
                                 // and private setter
  var size: Double = 45.0        // implicit internal property
  public let fullName: String    // public constant property
  
  init (id: Int, name: String, fullName: String) {
    
    // all properties initialized before base init invoked
    self.name = name;
    self.fullName = fullName;
    
    // super initialiser invoked
    super.init(id: id)
    
    // methods on self can now be called
  }
}

// creating an instance
var animal = Animal(id: 24, name: "cat", fullName: "Felis catus")



