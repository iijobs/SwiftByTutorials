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

struct GeoLocation {
  var latitude: Double
  var longitude: Double
  
  func distanceBetween(other: GeoLocation) -> Double {
    let locationA = CLLocation(latitude: self.latitude, longitude: self.longitude)
    let locationB = CLLocation(latitude: other.latitude, longitude: other.longitude)
    return locationA.distanceFromLocation(locationB)
  }
}

extension GeoLocation {
  
  var coordinate: CLLocationCoordinate2D { return CLLocationCoordinate2DMake(self.latitude, self.longitude) }
  
  var mapPoint: MKMapPoint { return MKMapPointForCoordinate(self.coordinate) }
  
}

extension GeoLocation: Equatable {
}

func ==(lhs: GeoLocation, rhs: GeoLocation) -> Bool {
  return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
}
