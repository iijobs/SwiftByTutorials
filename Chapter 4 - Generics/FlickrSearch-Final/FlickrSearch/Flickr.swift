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

let FLICKR_API_KEY = "978d7216fb7560fbd505ddc25c7bc264"

class Flickr {
  
  enum SearchResult {
    case Results([Photo])
    case Error
  }
  
  typealias SearchCompletion = (result: SearchResult) -> Void
  
  class func search(term: String, completion: SearchCompletion) {
    let encodedTerm = (term as NSString).stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
    let searchURLString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(FLICKR_API_KEY)&text=\(encodedTerm)&per_page=20&format=json&nojsoncallback=1"
    let request = NSURLRequest(URL: NSURL(string: searchURLString)!)
    
    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) in
      if error != nil {
        println("Flickr error: \(error)")
        completion(result: .Error)
        return
      }
      
      let results: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil)
      if results == nil {
        completion(result: .Error)
        return
      }
      
      if let json = JSONValue.fromObject(results) {
        let status = json["stat"]?.string
        let photos = json["photos"]?["photo"]?.array
        if status != nil && status! == "ok" && photos != nil {
          var flickrPhotos: [Photo] = []
          for photo in photos! {
            flickrPhotos.append(Photo.createFromJSON(photo))
          }
          completion(result: .Results(flickrPhotos))
          return
        }
      }
      
      // If we get here, then must be error
      completion(result: .Error)
    }
  }
  
  class Photo {
    
    var farm: Int = 0
    var server: String = ""
    var secret: String = ""
    var photoID: String = ""
    
    var image: UIImage?
    var thumbnail: UIImage?
    
    class func createFromJSON(json: JSONValue) -> Photo {
      var photo = Photo()
      
      if let farm = json["farm"]?.integer {
        photo.farm = farm
      }
      if let server = json["server"]?.string {
        photo.server = server
      }
      if let secret = json["secret"]?.string {
        photo.secret = secret
      }
      if let photoID = json["id"]?.string {
        photo.photoID = photoID
      }
      
      return photo
    }
    
    enum PhotoResult {
      case Image(UIImage)
      case Error
    }
    typealias PhotoCompletion = (result: PhotoResult) -> Void
    
    func loadImage(thumbnail: Bool, completion: PhotoCompletion) {
      if self.image != nil && !thumbnail {
        completion(result: .Image(self.image!))
      } else if self.thumbnail != nil && thumbnail {
        completion(result: .Image(self.thumbnail!))
      }
      
      let size = thumbnail ? "m" : "b"
      
      let photoURLString = "http://farm\(self.farm).staticflickr.com/\(self.server)/\(self.photoID)_\(self.secret)_\(size).jpg"
      let request = NSURLRequest(URL: NSURL(string: photoURLString)!)
      
      NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) in
        if data != nil {
          if let image = UIImage(data: data) {
            if thumbnail {
              self.thumbnail = image
            } else {
              self.image = image
            }
            completion(result: .Image(image))
          } else {
            completion(result: .Error)
          }
        } else {
          completion(result: .Error)
        }
      }
    }
    
  }
  
}
