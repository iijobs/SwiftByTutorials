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

class Cafe: NSObject {
  let fbid: String
  let name: String
  let location: CLLocationCoordinate2D
  let street: String
  let city: String
  let zip: String
  
  var pictureURL: NSURL {
  return NSURL(string: "http://graph.facebook.com/place/picture?id=\(self.fbid)&type=large")!
  }
  
  init(fbid: String, name: String, location: CLLocationCoordinate2D, street: String, city: String, zip: String) {
    self.fbid = fbid
    self.name = name
    self.location = location
    self.street = street
    self.city = city
    self.zip = zip
    super.init()
  }
  
  class func fromJSON(json: [String:JSONValue]) -> Cafe? {
    let fbid = json["id"]?.string
    let name = json["name"]?.string
    let latitude = json["location"]?["latitude"]?.double
    let longitude = json["location"]?["longitude"]?.double
    
    if fbid != nil && name != nil && latitude != nil && longitude != nil {
      var street: String
      if let maybeStreet = json["location"]?["street"]?.string {
        street = maybeStreet
      } else {
        street = ""
      }
      
      var city: String
      if let maybeCity = json["location"]?["city"]?.string {
        city = maybeCity
      } else {
        city = ""
      }
      
      var zip: String
      if let maybeZip = json["location"]?["zip"]?.string {
        zip = maybeZip
      } else {
        zip = ""
      }
      
      let location = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
      return Cafe(fbid: fbid!, name: name!, location: location, street: street, city: city, zip: zip)
    }
    return nil
  }
}

extension Cafe: MKAnnotation {
  
  var title: String! {
  return name
  }
  
  var coordinate: CLLocationCoordinate2D {
  return location
  }
  
}
