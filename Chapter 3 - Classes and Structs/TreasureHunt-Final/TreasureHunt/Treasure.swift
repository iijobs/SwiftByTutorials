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
import MapKit

@objc protocol Alertable {

  func alert() -> UIAlertController

}

class Treasure: NSObject {

  let what: String
  let location: GeoLocation
  
  init(what: String, location: GeoLocation) {
    self.what = what
    self.location = location
  }
  
  convenience init(what: String, latitude: Double, longitude: Double) {
    let location = GeoLocation(latitude: latitude, longitude: longitude)
    self.init(what: what, location: location)
  }

  func pinColor() -> MKPinAnnotationColor  {
    return MKPinAnnotationColor.Red
  }
  
}

extension Treasure: MKAnnotation {
  
  var coordinate: CLLocationCoordinate2D { return self.location.coordinate }
  
  var title: String { return self.what }
  
}

final class HistoryTreasure: Treasure {
  let year: Int
  
  init(what: String, year: Int, latitude: Double, longitude: Double) {
    self.year = year
    let location = GeoLocation(latitude: latitude, longitude: longitude)
    super.init(what: what, location: location)
  }

  override func pinColor() -> MKPinAnnotationColor  {
    return MKPinAnnotationColor.Purple
  }
  
}

extension HistoryTreasure: Alertable {
  
  func alert() -> UIAlertController {
    let alert = UIAlertController(title: "History", message: "From \(self.year):\n\(self.what)", preferredStyle: UIAlertControllerStyle.Alert)
    return alert
  }

}

final class FactTreasure: Treasure {
  let fact: String
  
  init(what: String, fact: String, latitude: Double, longitude: Double) {
    self.fact = fact
    let location = GeoLocation(latitude: latitude, longitude: longitude)
    super.init(what: what, location: location)
  }
  
}

extension FactTreasure: Alertable {
  
  func alert() -> UIAlertController {
    let alert = UIAlertController(title: "Fact", message: "\(self.what):\n\(self.fact)", preferredStyle: UIAlertControllerStyle.Alert)
    return alert
  }

}

final class HQTreasure: Treasure {
  let company: String
  
  init(company: String, latitude: Double, longitude: Double) {
    self.company = company
    let location = GeoLocation(latitude: latitude, longitude: longitude)
    super.init(what: company + " headquarters", location: location)
  }

  override func pinColor() -> MKPinAnnotationColor  {
    return MKPinAnnotationColor.Green
  }

}

extension HQTreasure: Alertable {
  
  func alert() -> UIAlertController {
    let alert = UIAlertController(title: "Headquarters", message: "The headquarters of \(self.company)", preferredStyle: UIAlertControllerStyle.Alert)
    return alert
  }

}
