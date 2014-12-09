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

@objc protocol CafeViewControllerDelegate {
  
  optional func cafeViewControllerDidFinish(viewController: CafeViewController)
  
}

class CafeViewController: UIViewController {
  
  var cafe: Cafe? {
    didSet {
      self.setupWithCafe()
    }
  }

  weak var delegate: CafeViewControllerDelegate?
  
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var streetLabel: UILabel!
  @IBOutlet var cityLabel: UILabel!
  @IBOutlet var zipLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupWithCafe()
  }
  
  private func setupWithCafe() {
    if !self.isViewLoaded() {
      return
    }
    
    if let cafe = self.cafe {
      self.title = cafe.name
      
      self.nameLabel.text = cafe.name
      self.streetLabel.text = cafe.street
      self.cityLabel.text = cafe.city
      self.zipLabel.text = cafe.zip
      
      let request = NSURLRequest(URL: cafe.pictureURL)
      NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
        (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
        let image = UIImage(data: data)
        self.imageView.image = image
      }
    }
  }
  
  @IBAction private func back(sender: AnyObject) {
    self.delegate?.cafeViewControllerDidFinish?(self)
  }
  
}
