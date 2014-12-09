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

@IBDesignable
class LoginView: UIView {
  
  var readPermissions: [String] = []
  
  @IBInspectable var cornerRadius: CGFloat = 0.0 {
    didSet {
      layer.cornerRadius = cornerRadius
    }
  }
  @IBInspectable var borderWidth: CGFloat = 1.0 {
    didSet {
      layer.borderWidth = borderWidth
    }
  }
  @IBInspectable var borderColor: UIColor = UIColor.blackColor() {
    didSet {
      layer.borderColor = borderColor.CGColor
    }
  }
  
  var button: UIButton!
  
  init(readPermissions: [String]) {
    self.readPermissions = readPermissions
    super.init(frame: CGRectZero)
    self.initialize()
  }
  
  convenience override init(frame: CGRect) {
    self.init(readPermissions: [])
    self.frame = frame
  }
  
  required init(coder aDecoder: NSCoder) {
    self.readPermissions = []
    super.init(coder: aDecoder)
    self.initialize()
  }
  
  func initialize() {
    self.backgroundColor = UIColor.blueColor()
    
    let button = UIButton.buttonWithType(.Custom) as UIButton
    button.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
    self.addSubview(button)
    self.button = button
    self.updateButtonState()
    
    FBSession.openActiveSessionWithReadPermissions(nil, allowLoginUI: false) {
      (session: FBSession!, state: FBSessionState, error: NSError!) -> Void in
      self.updateButtonState()
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.button.frame = self.bounds
  }
  
  func updateButtonState() {
    var title: String
    if FBSession.activeSession().isOpen {
      title = "Log out"
    } else {
      title = "Log in"
    }
    button.setTitle(title, forState: .Normal)
  }
  
  func buttonPressed(sender: AnyObject) {
    if !FBSession.activeSession().isOpen {
      FBSession.openActiveSessionWithReadPermissions(self.readPermissions, allowLoginUI: true) {
        (session: FBSession!, state: FBSessionState, error: NSError!) -> Void in
        self.updateButtonState()
      }
    } else {
      FBSession.activeSession().closeAndClearTokenInformation()
    }
  }
  
}
